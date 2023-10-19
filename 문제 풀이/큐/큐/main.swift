/*
 문제
 정수를 저장하는 큐를 구현한 다음, 입력으로 주어지는 명령을 처리하는 프로그램을 작성하시오.

 명령은 총 여섯 가지이다.

 push X: 정수 X를 큐에 넣는 연산이다.
 pop: 큐에서 가장 앞에 있는 정수를 빼고, 그 수를 출력한다. 만약 큐에 들어있는 정수가 없는 경우에는 -1을 출력한다.
 size: 큐에 들어있는 정수의 개수를 출력한다.
 empty: 큐가 비어있으면 1, 아니면 0을 출력한다.
 front: 큐의 가장 앞에 있는 정수를 출력한다. 만약 큐에 들어있는 정수가 없는 경우에는 -1을 출력한다.
 back: 큐의 가장 뒤에 있는 정수를 출력한다. 만약 큐에 들어있는 정수가 없는 경우에는 -1을 출력한다.
 입력
 첫째 줄에 주어지는 명령의 수 N (1 ≤ N ≤ 2,000,000)이 주어진다. 둘째 줄부터 N개의 줄에는 명령이 하나씩 주어진다. 주어지는 정수는 1보다 크거나 같고, 100,000보다 작거나 같다. 문제에 나와있지 않은 명령이 주어지는 경우는 없다.

 출력
 출력해야하는 명령이 주어질 때마다, 한 줄에 하나씩 출력한다.
 */

//MARK: 다른 풀이
import Foundation

// 빠른 입력 FileIO
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

struct Queue {
    private var array: [Int] = []
    private var index: Int = 0
    
    var size: Int {
        return array.count - index
    }
    
    var front: Int {
        return self.isEmpty ? -1 : array[index]
    }
    
    var back: Int {
        return self.isEmpty ? -1 : array.last!
    }
    
    var empty: Int {
        return self.isEmpty ? 1 : 0
    }
    
    var isEmpty: Bool {
        return array.count - index <= 0
    }
    
    mutating func push(_ element: Int) {
        array.append(element)
    }
    
    mutating func pop() -> Int {
        guard !self.isEmpty else {
            return -1
        }
        let element = array[index]
        index += 1
        return element
    }
}

let file = FileIO()
let n = file.readInt()
var queue: Queue = Queue()
var answer = ""

for _ in 0..<n {
    let command = file.readString()
    switch command {
    case 448:
        // push
        queue.push(file.readInt())
    case 335:
        // pop
        answer += "\(queue.pop())\n"
    case 443:
        // size
        answer += "\(queue.size)\n"
    case 559:
        // empty
        answer += "\(queue.empty)\n"
    case 553:
        // front
        answer += "\(queue.front)\n"
    case 401:
        // back
        answer += "\(queue.back)\n"
    default:
        continue
    }
}
print(answer)





//MARK: - 내 풀이
/*
import Foundation

var queue = Queue()
var fileIO = FileIO()

for _ in 0..<fileIO.readInt() {
    var input = readLine()!.split(separator: " ").map{String($0)}
    
    switch input[0]{
    case "push" :
        queue.push(element: Int(input[1])!)
        
    case "pop" :
//        var result = queue.size == 0 ? -1 : queue.pop()
        print(queue.size == 0 ? -1 : queue.pop())
        
    case "size" :
        print(queue.size)
        
    case "empty" :
        var result = queue.size == 0 ? 1 : 0
        print(result)
        
    case "front" :
        var result = queue.size == 0 ? -1 : queue.front!.value
        print(result)
        
    case "back" :
        var result = queue.size == 0 ? -1 : queue.back!.value
        print(result)
        
    default :
        print("default")
    }
    
}


class Queue {
    var size: Int = 0
    var front: QueueNode?
    var back: QueueNode?
    
    func push(element: Int){
        var node = QueueNode(value: element)
        if size == 0 {
            front = node
            back = node
        }
        else {
            front?.next = node
            back = node
        }
        size = size + 1
    }
    
    func pop() -> Int{
        if (size == 0){
            return -1
        }
        
        else if (size == 1){
            var value = front?.value
            front = nil
            size = 0
            return value!
        }
        
        else{
            var value = front?.value
            front = front?.next
            size = size - 1
            return value!
        }
    }
    
    
    
}

class QueueNode {
    var next: QueueNode?
    var value: Int
    
    init(value: Int) {
        self.value = value
    }
}

*/

