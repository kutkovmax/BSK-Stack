#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char color; // 'W', 'B', 'R'
    int value;
} Node;

typedef struct {
    Node *data;
    size_t cap;
    size_t n;
    double whiteRatio;
    double blueRatio;
} BSKStack;

BSKStack* bsk_new(double w, double b) {
    BSKStack *s = malloc(sizeof(BSKStack));
    s->cap = 16; s->n = 0;
    s->data = malloc(sizeof(Node)*s->cap);
    s->whiteRatio = w; s->blueRatio = b;
    return s;
}
void ensure_cap(BSKStack *s) {
    if(s->n >= s->cap) {
        s->cap *= 2;
        s->data = realloc(s->data, sizeof(Node)*s->cap);
    }
}
void bsk_push(BSKStack *s, int v) {
    ensure_cap(s);
    // insert at front
    memmove(&s->data[1], &s->data[0], sizeof(Node)*s->n);
    s->data[0].color = 'W';
    s->data[0].value = v;
    s->n++;
}
void bsk_zones(BSKStack *s, size_t *w, size_t *b) {
    size_t n = s->n;
    *w = (size_t)(n * s->whiteRatio);
    *b = (size_t)(n * (s->whiteRatio + s->blueRatio));
}
int bsk_pop(BSKStack *s, int *out) {
    if(s->n == 0) return 0;
    size_t w,b; bsk_zones(s,&w,&b);
    for(size_t i=0;i<w && i<s->n;i++){
        if(s->data[i].color=='W' || s->data[i].color=='B') {
            *out = s->data[i].value;
            memmove(&s->data[i], &s->data[i+1], sizeof(Node)*(s->n-i-1));
            s->n--; return 1;
        }
    }
    for(size_t i=w;i<b && i<s->n;i++){
        if(s->data[i].color=='B') {
            *out = s->data[i].value;
            memmove(&s->data[i], &s->data[i+1], sizeof(Node)*(s->n-i-1));
            s->n--; return 1;
        }
    }
    // red locked
    return -1;
}
void bsk_update(BSKStack *s) {
    size_t w,b; bsk_zones(s,&w,&b);
    for(size_t i=0;i<s->n;i++){
        if(i < w) s->data[i].color='W';
        else if(i < b) s->data[i].color='B';
        else s->data[i].color='R';
    }
}
size_t bsk_len(BSKStack *s){ return s->n;}
void bsk_free(BSKStack *s){ free(s->data); free(s); }