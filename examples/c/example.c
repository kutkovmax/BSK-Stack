#include <stdio.h>
#include "../../src/c/bsk_stack.h"

int main() {
    BSKStack st;
    bsk_init(&st, 0.3, 0.4);

    bsk_push(&st, 10);
    bsk_push(&st, 20);
    bsk_push(&st, 30);

    bsk_update_colors(&st);

    printf("Initial stack:\n");
    bsk_print(&st);

    int v = bsk_pop(&st);
    printf("Popped: %d\n", v);

    bsk_update_colors(&st);

    printf("After pop:\n");
    bsk_print(&st);

    return 0;
}
