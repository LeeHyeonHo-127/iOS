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

while true{
    let n = Int(readLine()!)!
    var queue = Queue()

    for i in 1...n {
        queue.push(value: i)
    }

    while queue.size > 0 {
        
        if queue.size == 1{
            print("\(queue.front!.value)")
            print("---------------------------------------------")
            break
        }
        
        queue.pop()
        
        if queue.size > 1{
            guard let pop = queue.pop() else {print("size = \(queue.size)") ; break}
            
            queue.push(value: pop.value)
        }
    }


    final class Queue {
        var front: QueueNode?
        var back: QueueNode?
        var size = 0
        
        func pop() -> QueueNode? {
            
            if size == 0 {
                return nil
            }
            
            var top = front
            front = front?.next
            size = size == 0 ? 0 : size - 1
            return top
        }
        
        func push(value: Int) {
            var node = QueueNode(value: value)
            
            if size == 0 {
                front = node
                back = node
            }
            
            back?.next = node
            back = node
            size = size + 1
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
}


//MARK: - 다른 풀이
/*
//큐로 풀지 않고 2의 제곱을 이용해서 품

let N = Int(readLine()!)!

var i = 1
while true {
    if N >= i , N < i*2 {
        break
    }else{
        i *= 2
    }
}
let remain = N-i
if remain == 0 {
    print(i)
}else {
    print(2*remain)
}
*/

