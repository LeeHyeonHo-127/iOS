import Foundation

struct heapTree<T>{
    private var elements: [T] = []
    private var sortFunction: (T,T) -> Bool
    var isEmpty: Bool{
        return self.elements.isEmpty
    }
    var peek: T?{
        if self.elements.isEmpty{
            return nil
        }else{
            return self.elements[1]
        }
    }
    var count: Int{
        return self.elements.count
    }
    init(elements: [T],  sortFunction: @escaping (T,T) -> Bool){
        if !elements.isEmpty{
            self.elements = [elements.first!] + elements
        }else{
            self.elements = elements
        }
        self.sortFunction = sortFunction
        
        if(self.elements.count > 1){
            //            self.buildheap()
        }
    }
    func leftChild(of index: Int)->Int{
        return index*2
    }
    func rightChild(of index: Int)->Int{
        return index*2+1
    }
    func parent(of index: Int)->Int{
        return index/2
    }
    
    mutating func swimUp(index: Int){
        var index = index
        if(index != 1 && sortFunction(elements[index], elements[self.parent(of: index)])){
            self.elements.swapAt(index, self.parent(of: index))
            index = self.parent(of: index)
            swimUp(index: index)
        }
    }
    
    mutating func insert(data: T){
        if self.elements.isEmpty {
            self.elements = [data] + [data]
        }else{
            self.elements.append(data)
        }
        self.swimUp(index: elements.count)
    }
    
    mutating func diveDown(index: Int){
        var higherPriority = index
        let leftIndex = self.leftChild(of: index)
        let rightIndex = self.rightChild(of: index)
        
        if leftIndex < self.elements.endIndex && self.sortFunction(self.elements[leftIndex], self.elements[higherPriority]){
            higherPriority = leftIndex
        }
        if rightIndex < self.elements.endIndex && self.sortFunction(self.elements[rightIndex], self.elements[higherPriority]){
            higherPriority = rightIndex
        }
        if higherPriority != index{
            self.elements.swapAt(higherPriority, index)
            self.diveDown(index: higherPriority)
        }
    }
    
    mutating func buildHeap(){
        for index in (1...(self.elements.count / 2)).reversed(){
            self.diveDown(index: index)
        }
    }
}
