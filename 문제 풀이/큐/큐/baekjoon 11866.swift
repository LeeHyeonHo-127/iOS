import Foundation

/*
 
Baekjoon 11866
 
 문제
 요세푸스 문제는 다음과 같다.

 1번부터 N번까지 N명의 사람이 원을 이루면서 앉아있고, 양의 정수 K(≤ N)가 주어진다. 이제 순서대로 K번째 사람을 제거한다. 한 사람이 제거되면 남은 사람들로 이루어진 원을 따라 이 과정을 계속해 나간다. 이 과정은 N명의 사람이 모두 제거될 때까지 계속된다. 원에서 사람들이 제거되는 순서를 (N, K)-요세푸스 순열이라고 한다. 예를 들어 (7, 3)-요세푸스 순열은 <3, 6, 2, 7, 5, 1, 4>이다.

 N과 K가 주어지면 (N, K)-요세푸스 순열을 구하는 프로그램을 작성하시오.

 입력
 첫째 줄에 N과 K가 빈 칸을 사이에 두고 순서대로 주어진다. (1 ≤ K ≤ N ≤ 1,000)

 출력
 예제와 같이 요세푸스 순열을 출력한다.

*/

//MARK: - 내 풀이

/*

var circularQueue = CircularQueue()
var input = readLine()!.split(separator: " ")
var outputArray: [Int] = []

for i in 1...Int(input[0])!{
    circularQueue.push(value: i)
}

var now: QueueNode = QueueNode(value: -1, next: circularQueue.front)

while circularQueue.size > 0 {
    
    var count = 0
    
    while(count < Int(input[1])!){
        if now.next!.value != -1 {
            now = now.next!
            count = count + 1
        }
        else {
            now = now.next!
        }
    }
    
    count = 0
    
    outputArray.append(now.value)
    now.value = -1
    circularQueue.size = circularQueue.size - 1
}

print("<", terminator: "")
for i in 0..<outputArray.count - 1{
    print("\(outputArray[i]), ", terminator: "")
}
print("\(outputArray.last!)>")


final class CircularQueue {
    var front: QueueNode?
    var back: QueueNode?
    var size = 0
    
    func push(value: Int) {
        var node = QueueNode(value: value)
        
        if size == 0 {
            front = node
            back = node
            size = size + 1
        }
        else{
            node.next = front
            back?.next = node
            back = node
            size = size + 1
        }
    }
}

final class QueueNode{
        var value: Int
        var next: QueueNode?
        
        init(value: Int, next: QueueNode? = nil) {
        self.value = value
        self.next = next
    }
}

*/

//MARK: - 다른사람 풀이
/*

let read = readLine()!.split(separator: " ").map { Int($0)! }
let n = read[0], m = read[1]

var array = (1...n).map { String($0) }
var ans : [String]  = []
var idx = 0
while array.count > 0 {
    idx = (idx + m - 1) % array.count
    ans.append(array[idx])
    array.remove(at: idx)
}
print("<"+ans.joined(separator: ", ")+">")
*/
