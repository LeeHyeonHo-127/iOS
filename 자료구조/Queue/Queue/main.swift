import Foundation

class Queue<T>{
    var elements:[T] = []
    var count: Int{return self.elements.count}
    var isEmpty: Bool{return self.elements.isEmpty}
    
    func enqueue(element: T){
        elements.append(element)
    }
    func dequeue()-> T?{
        return isEmpty ? nil : elements.removeFirst()
    }
}

    
var queue = Queue<Int>()
queue.enqueue(element: 1)
queue.enqueue(element: 2)
queue.enqueue(element: 3)
        
for _ in 0..<3{
    print(queue.dequeue())
} // 1 2 3
    
    

