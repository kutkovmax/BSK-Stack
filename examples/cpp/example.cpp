#include <iostream>
#include "../../src/cpp/bsk_stack.hpp"

int main() {
    BSKStack<int> st;

    st.push(10);
    st.push(20);
    st.push(30);

    st.updateColors();
    std::cout << "Initial stack: " << st << std::endl;

    int v = st.pop();
    std::cout << "Popped: " << v << std::endl;

    st.updateColors();
    std::cout << "After pop: " << st << std::endl;

    return 0;
}
