import Foundation

struct Heap<T: Comparable>{
    var heap: Array<T> = []
    
    init(){}
    init(data: T){
        heap.append(data)
        heap.append(data)
//        print("init")
    }
    
    mutating func insert(data:T){
        heap.append(data)
        var currentIndex = heap.count-1
        
        if(heap.isEmpty){
            heap.append(data)
            heap.append(data)
            return
        }
        
        while(true){
//            print("currentIndex = \(currentIndex)")
//            print(heap)
            if(currentIndex == 1) {return}
            if(heap[currentIndex] > heap[currentIndex/2]){
                heap.swapAt(currentIndex, currentIndex/2)
                currentIndex = currentIndex/2
            }else{
                currentIndex = currentIndex/2
            }
        }
    }
    
    mutating func pop() -> T{
        let root = heap[1]
        var cur = 1
        
        heap[cur] = heap[heap.count-1]
        heap.remove(at: heap.count-1)
        
        while(true){
            //현재 노드의 자식이 없는경우
            if(cur*2 > heap.count-2){
                break
            }
            //왼쪽 자식만 있는경우
            else if(cur*2+1 > heap.count-1){
                if (heap[cur] < heap[cur*2]){
                    heap.swapAt(cur,cur*2)
                    cur = cur*2
                }
            }
            //자식 둘 다 있는경우
            else{
                var bigChildIndex = heap[cur*2]>heap[cur*2+1] ? cur*2 : cur*2+1
                heap.swapAt(cur, bigChildIndex)
                cur = bigChildIndex
            }
        }
        return root
    }
}
