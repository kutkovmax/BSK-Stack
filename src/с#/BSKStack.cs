using System;
using System.Collections.Generic;

public class BSKStack<T> {
    private List<(char color, T value)> data = new List<(char,T)>();
    private double whiteRatio;
    private double blueRatio;

    public BSKStack(double w = 0.3, double b = 0.4) {
        whiteRatio = w; blueRatio = b;
    }

    private (int w, int b) Zones() {
        int n = data.Count;
        int widx = (int)(n * whiteRatio);
        int bidx = (int)(n * (whiteRatio + blueRatio));
        return (widx, bidx);
    }

    public void Push(T v) {
        data.Insert(0, ('W', v));
    }

    // returns true and out value, false if empty, throws if red-locked
    public bool Pop(out T v) {
        v = default(T);
        if (data.Count == 0) return false;
        var (w, b) = Zones();
        for (int i = 0; i < Math.Min(w, data.Count); i++)
            if (data[i].color == 'W' || data[i].color == 'B') {
                v = data[i].value;
                data.RemoveAt(i);
                return true;
            }
        for (int i = w; i < Math.Min(b, data.Count); i++)
            if (data[i].color == 'B') {
                v = data[i].value;
                data.RemoveAt(i);
                return true;
            }
        throw new InvalidOperationException("Red zone is locked");
    }

    public void UpdateColors() {
        var (w,b) = Zones();
        for (int i=0;i<data.Count;i++) {
            if (i < w) data[i] = ('W', data[i].value);
            else if (i < b) data[i] = ('B', data[i].value);
            else data[i] = ('R', data[i].value);
        }
    }

    public int Size() => data.Count;
}