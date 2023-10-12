import Foundation

/*
 문제
 정수를 저장하는 스택을 구현한 다음, 입력으로 주어지는 명령을 처리하는 프로그램을 작성하시오.

 명령은 총 다섯 가지이다.

 1 X: 정수 X를 스택에 넣는다. (1 ≤ X ≤ 100,000)
 2: 스택에 정수가 있다면 맨 위의 정수를 빼고 출력한다. 없다면 -1을 대신 출력한다.
 3: 스택에 들어있는 정수의 개수를 출력한다.
 4: 스택이 비어있으면 1, 아니면 0을 출력한다.
 5: 스택에 정수가 있다면 맨 위의 정수를 출력한다. 없다면 -1을 대신 출력한다.
 입력
 첫째 줄에 명령의 수 N이 주어진다. (1 ≤ N ≤ 1,000,000)

 둘째 줄부터 N개 줄에 명령이 하나씩 주어진다.

 출력을 요구하는 명령은 하나 이상 주어진다.

 출력
 출력을 요구하는 명령이 주어질 때마다 명령의 결과를 한 줄에 하나씩 출력한다.
 */



// MARK: - 내 풀이

/*
let num = Int(readLine()!)!
var stack = StackStruct()

for _ in 0..<num{
    let input = readLine()!.split(separator: " ").map{Int($0)!}
    
    if input[0] == 1{
        stack.push(item: input[1])
    }
    else if input[0] == 2{
        print(stack.pop())
    }
    else if input[0] == 3{
        print(stack.size())
    }
    else if input[0] == 4{
        print(stack.isEmpty())
    }
    else if input[0] == 5{
        print(stack.top())
    }
}


struct StackStruct{
    
    var array:[Int] = []

    
    mutating func push(item: Int){
        array.append(item)
    }

    mutating func pop() -> Int {
        if (array.isEmpty == true) {
            return -1
        }
        else{
            return array.removeLast()
        }
    }
    
    func size() -> Int {
        return array.count
    }
    
    func isEmpty() -> Int {
        if array.isEmpty {return 1}
        else {return 0}
    }
    
    func top() -> Int {
        if array.isEmpty {return -1 }
        
        else {
            return array.last!
        }
    }
    
    
    func printAll(){
        array.forEach{
            print($0 ,terminator: " ")
        }
    }
}
*/

//MARK: - 다른 풀이


var buffer: [UInt8] = Array(FileHandle.standardInput.readDataToEndOfFile()), byteIdx = 0; buffer.append(0)

@inline(__always) func readByte() -> UInt8 {
    defer { byteIdx += 1 }
    return buffer.withUnsafeBufferPointer { $0[byteIdx] }
}

@inline(__always) func readInt() -> Int {
    var number = 0, byte = readByte(), isNegative = false
    while byte == 10 || byte == 32 { byte = readByte() }
    if byte == 45 { byte = readByte(); isNegative = true }
    while 48...57 ~= byte { number = number * 10 + Int(byte - 48); byte = readByte() }
    return number * (isNegative ? -1 : 1)
}

var stack = [Int](), answer = ""
for _ in 0..<readInt() {
    switch readInt() {
    case 1: stack.append(readInt())
    case 2: answer.write("\(stack.popLast() ?? -1)\n")
    case 3: answer.write("\(stack.count)\n")
    case 4: answer.write("\(stack.isEmpty ? 1 : 0)\n")
    case 5: answer.write("\(stack.last ?? -1)\n")
    default: break
    }
}
print(answer)





