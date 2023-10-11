import Foundation

class Stack<T>{
    var elements:[T] = []
    
    var count: Int {return self.elements.count}
    var isEmpty:Bool { return self.elements.isEmpty}
    
    func push(element: T){
        elements.append(element)
    }
    func pop()-> T?{
        return elements.popLast()
    }
    func top()-> T?{
        return elements.last
    }
}

var stack = Stack<Int>()
stack.push(element: 1)
stack.push(element: 2)
stack.push(element: 3)

for _ in 0..<3{
    print(stack.pop())
}


//3
//2
//1
