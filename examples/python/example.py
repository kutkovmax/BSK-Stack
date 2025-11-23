import sys
sys.path.append("../../src/python")

from bsk_stack import BSKStack

stack = BSKStack()

stack.push(10)
stack.push(20)
stack.push(30)

stack.update_colors()
print("Initial stack:", stack)

print("Popped:", stack.pop())

stack.update_colors()
print("After pop:", stack)
