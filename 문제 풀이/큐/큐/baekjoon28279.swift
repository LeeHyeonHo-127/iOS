/*

Baekjoon 28279

 문제
 정수를 저장하는 덱을 구현한 다음, 입력으로 주어지는 명령을 처리하는 프로그램을 작성하시오.

 명령은 총 여덟 가지이다.

 1 X: 정수 X를 덱의 앞에 넣는다. (1 ≤ X ≤ 100,000)
 2 X: 정수 X를 덱의 뒤에 넣는다. (1 ≤ X ≤ 100,000)
 3: 덱에 정수가 있다면 맨 앞의 정수를 빼고 출력한다. 없다면 -1을 대신 출력한다.
 4: 덱에 정수가 있다면 맨 뒤의 정수를 빼고 출력한다. 없다면 -1을 대신 출력한다.
 5: 덱에 들어있는 정수의 개수를 출력한다.
 6: 덱이 비어있으면 1, 아니면 0을 출력한다.
 7: 덱에 정수가 있다면 맨 앞의 정수를 출력한다. 없다면 -1을 대신 출력한다.
 8: 덱에 정수가 있다면 맨 뒤의 정수를 출력한다. 없다면 -1을 대신 출력한다.
 입력
 첫째 줄에 명령의 수 N이 주어진다. (1 ≤ N ≤ 1,000,000)

 둘째 줄부터 N개 줄에 명령이 하나씩 주어진다.

 출력을 요구하는 명령은 하나 이상 주어진다.

 출력
 출력을 요구하는 명령이 주어질 때마다 명령의 결과를 한 줄에 하나씩 출력한다.

*/

//MARK: - 내 풀이
/*
import Foundation

private var file = FileIO()
private var dequeue = Dequeue()

for _ in 0..<file.readInt() {
    
    
    switch file.readInt(){
    case 1 :
        dequeue.appendLeft(value: file.readInt())
    case 2:
        dequeue.appendRight(value: file.readInt())
    case 3:
        print(dequeue.popFront())
    case 4:
        print(dequeue.popRear())
    case 5:
        print(dequeue.size)
    case 6:
        print(dequeue.size == 0 ? 1 : 0)
    case 7:
        print(dequeue.getFrontValue())
    case 8:
        print(dequeue.getRearValue())
    default:
        print("default!")
    }
}



final class Dequeue {
    var size = 0
    var front: DequeueNode?
    var rear: DequeueNode?
    
    func appendLeft(value: Int){
        var node = DequeueNode(value: value)
        
        if size == 0{
            front = node
            rear = node
            size += 1
        }
        
        else{
            node.next = front
            front?.before = node
            front = node
            size += 1
        }
    }
     
    func appendRight(value: Int){
        var node = DequeueNode(value: value)
        
        if size == 0{
            front = node
            rear = node
            size += 1
        }
        
        else{
            node.before = rear
            rear?.next = node
            rear = node
            size += 1
        }
    }
    
    func popFront() -> Int {
        if size == 0 { return -1 }
        
        var node = front
        front = front?.next
        size -= 1
        return node!.value
    }
    
    func popRear() -> Int {
        if size == 0 { return -1 }
        
        var node = rear
        rear = rear?.before
        size -= 1
        return node!.value
    }
    
    func getFrontValue() -> Int {
        if size == 0 { return -1 }
        return(front!.value)
    }
    
    
    func getRearValue() -> Int {
        if size == 0 { return -1 }
        return(rear!.value)
    }
    
}

final class DequeueNode {
    var before: DequeueNode?
    var next: DequeueNode?
    var value: Int
    
    init(before: DequeueNode? = nil, next: DequeueNode? = nil, value: Int) {
        self.before = before
        self.next = next
        self.value = value
    }
}






final class FileIO {
    private var buffer: [UInt8]
    private var index: Int
    
    init(fileHandle: FileHandle = FileHandle.standardInput){
        buffer = Array(fileHandle.readDataToEndOfFile()) + [UInt8(0)]
        index = 0
    }
    
    @inline(__always) private func read() -> UInt8{
        defer { index += 1}
        
        return buffer.withUnsafeBufferPointer{ $0[index] }
    }
    
    @inline(__always) func readInt() -> Int{
        var sum = 0
        var now = read()
        var isPositive = true
        
        while now == 10 ||
                now == 32 { now = read() }
        if now == 45 { isPositive.toggle(); now = read() }
        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now-48)
            now = read()
        }
        
        return sum * (isPositive ? 1 : -1)
    }
    
}

*/


//MARK: - 다른사람 풀이
/*
 import Foundation

 // 라이노님 빠른 입력 FileIO
 final class FileIO {
     private var buffer:[UInt8]
     private var index: Int
     
     init(fileHandle: FileHandle = FileHandle.standardInput) {
         buffer = Array(fileHandle.readDataToEndOfFile())+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
         index = 0
     }
     
     @inline(__always) private func read() -> UInt8 {
         defer { index += 1 }
         
         return buffer.withUnsafeBufferPointer { $0[index] }
     }
     
     @inline(__always) func readInt() -> Int {
         var sum = 0
         var now = read()
         var isPositive = true
         
         while now == 10
                 || now == 32 { now = read() } // 공백과 줄바꿈 무시
         if now == 45{ isPositive.toggle(); now = read() } // 음수 처리
         while now >= 48, now <= 57 {
             sum = sum * 10 + Int(now-48)
             now = read()
         }
         
         return sum * (isPositive ? 1:-1)
     }
     
     @inline(__always) func readString() -> Int {
         var str = 0
         var now = read()
         
         while now == 10
                 || now == 32 { now = read() } // 공백과 줄바꿈 무시
         
         while now != 10
                 && now != 32 && now != 0 {
             str += Int(now)
             now = read()
         }
         
         return str
     }
 }

 struct Deque<T> {
     private var leftArray: [T] = []
     private var rightArray: [T] = []
     private var leftIndex: Int = 0
     private var rightIndex: Int = 0
     
     var isEmpty: Bool {
         return leftIndex + rightIndex >= leftArray.count + rightArray.count
     }
     
     var size: Int {
         return (leftArray.count + rightArray.count) - (leftIndex + rightIndex)
     }
     
     var front: T? {
         if isEmpty {
             return nil
         }
         
         if leftIndex >= leftArray.count {
             return rightArray[rightIndex]
         }
         
         return leftArray.last
     }
     
     var back: T? {
         if isEmpty {
             return nil
         }
         
         if rightIndex >= rightArray.count {
             return leftArray[leftIndex]
         }
         
         return rightArray.last
     }
     
     mutating func pushLeft(_ element: T) {
         leftArray.append(element)
     }
     
     mutating func popLeft() -> T? {
         if isEmpty {
             return nil
         }
         
         if leftIndex >= leftArray.count {
             let element = rightArray[rightIndex]
             rightIndex += 1
             return element
         }
         
         return leftArray.popLast()
     }
     
     mutating func pushRight(_ element: T) {
         rightArray.append(element)
     }
     
     mutating func popRight() -> T? {
         if isEmpty {
             return nil
         }
         
         if rightIndex >= rightArray.count {
             let element = leftArray[leftIndex]
             leftIndex += 1
             return element
         }
         
         return rightArray.popLast()
     }
 }

 let file = FileIO()
 let n = file.readInt()
 var answer = ""
 var deque = Deque<Int>()

 for _ in 0..<n {
     let c = file.readInt()
     switch c {
     case 1:
         let x = file.readInt()
         deque.pushLeft(x)
     case 2:
         let x = file.readInt()
         deque.pushRight(x)
     case 3:
         answer += "\(deque.popLeft() ?? -1)\n"
     case 4:
         answer += "\(deque.popRight() ?? -1)\n"
     case 5:
         answer += "\(deque.size)\n"
     case 6:
         answer += "\(deque.isEmpty ? 1 : 0)\n"
     case 7:
         answer += "\(deque.front ?? -1)\n"
     case 8:
         answer += "\(deque.back ?? -1)\n"
     default: fatalError()
     }
 }

 print(answer)
 */
