import Foundation

class Queue<T>{
    var queueArray:[T] = []
    var isEmpty = queueArray.isEmpty
    
    func inqueue(data: T){
        queueArray.append(data)
    }
    
    func dequeue()->T{
        return queueArray.removeFirst()
    }
}
