#pragma once
#include <vector>
#include <stdexcept>
#include <string>

template<typename T>
class BSKStack {
    struct Node {
        std::string color;
        T value;
    };

    std::vector<Node> data;
    double whiteRatio;
    double blueRatio;

public:
    BSKStack(double wr = 0.3, double br = 0.4)
        : whiteRatio(wr), blueRatio(br) {}

    void push(const T& value) {
        data.insert(data.begin(), Node{"W", value});
    }

    T pop() {
        if (data.empty())
            throw std::runtime_error("Empty BSKStack");

        int w, b;
        zones(w, b);

        // white zone
        for (int i = 0; i < w; ++i) {
            if (data[i].color == "W" || data[i].color == "B") {
                T v = data[i].value;
                data.erase(data.begin() + i);
                return v;
            }
        }

        // blue zone
        for (int i = w; i < b; ++i) {
            if (data[i].color == "B") {
                T v = data[i].value;
                data.erase(data.begin() + i);
                return v;
            }
        }

        throw std::runtime_error("Red zone is locked");
    }

    void updateColors() {
        int w, b;
        zones(w, b);

        for (int i = 0; i < (int)data.size(); ++i) {
            if (i < w) data[i].color = "W";
            else if (i < b) data[i].color = "B";
            else data[i].color = "R";
        }
    }

private:
    void zones(int &w, int &b) {
        int n = data.size();
        w = int(n * whiteRatio);
        b = int(n * (whiteRatio + blueRatio));
    }
};
