import Foundation

class Queue<T>{
    var queueArray:[T] = []
    
    
    func inqueue(data: T){
        queueArray.append(data)
    }
    
    func dequeue()->T{
        return queueArray.removeFirst()
    }
    
    func isEmpty()->Bool{
        return self.queueArray.isEmpty
    }
    func queueCount()->Int{
        return self.queueArray.count
    }
    
}
