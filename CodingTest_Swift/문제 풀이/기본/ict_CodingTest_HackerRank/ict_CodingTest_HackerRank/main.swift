import Foundation

/*
func getMinRooms(meetingTimings: [[Int]]) -> Int {
    
    var meetings = meetingTimings.sorted(by: {$0[0] < $1[0]})
    var meetingRooms: [[Int]] = []
    var check = 0
    
    print(meetings)

    meetingRooms.append(meetings[0])
    
    for i in 1..<meetings.count{
        for j in 0..<meetingRooms.count{
            if(meetings[i][0] >= meetingRooms[j][1]){
//                print("in if 문")
//                print("\(meetingRooms[j]) <- \(meetings[i])")
                meetingRooms[j] = meetings[i]
                check = 1
            }
        }
        if(check != 1){
//            print("\(meetings[i]) 미팅룸 ++")
            meetingRooms.append(meetings[i])
        }else{
            check = 0
        }
        
    }
    
    return meetingRooms.count
}
*/

//func getMinRooms(meetingTimings: [[Int]]) -> Int {
//    let sortedMeetings = meetingTimings.sorted { $0[0] < $1[0] }
//    var meetingRooms: [[Int]] = []
//
//    for meeting in sortedMeetings {
//        var allocatedRoom = false
//
//        for i in 0..<meetingRooms.count {
//            if meeting[0] >= meetingRooms[i][1] {
//                meetingRooms[i] = meeting
//                allocatedRoom = true
//                break
//            }
//        }
//
//        if !allocatedRoom {
//            meetingRooms.append(meeting)
//        }
//    }
//
//    return meetingRooms.count
//}

//struct MaxHeap<Element: Comparable> {
//    var elements: [Element] = []
//
//    var isEmpty: Bool {
//        return elements.isEmpty
//    }
//
//    var count: Int {
//        return elements.count
//    }
//
//    mutating func insert(_ element: Element) {
//        elements.append(element)
//        siftUp(from: elements.count - 1)
//    }
//
//    mutating func siftUp(from index: Int) {
//        var child = index
//        var parent = parentIndex(of: child)
//
//        while child > 0 && elements[child] > elements[parent] {
//            elements.swapAt(child, parent)
//            child = parent
//            parent = parentIndex(of: child)
//        }
//    }
//
//    mutating func pop() -> Element? {
//        guard !isEmpty else {
//            return nil
//        }
//
//        elements.swapAt(0, count - 1)
//        let element = elements.removeLast()
//        siftDown(from: 0)
//        return element
//    }
//
//    mutating func siftDown(from index: Int) {
//        var parent = index
//
//        while true {
//            let leftChild = leftChildIndex(of: parent)
//            let rightChild = rightChildIndex(of: parent)
//            var candidate = parent
//
//            if leftChild < count && elements[leftChild] > elements[candidate] {
//                candidate = leftChild
//            }
//
//            if rightChild < count && elements[rightChild] > elements[candidate] {
//                candidate = rightChild
//            }
//
//            if candidate == parent {
//                return
//            }
//
//            elements.swapAt(parent, candidate)
//            parent = candidate
//        }
//    }
//
//    func parentIndex(of index: Int) -> Int {
//        return (index - 1) / 2
//    }
//
//    func leftChildIndex(of index: Int) -> Int {
//        return index * 2 + 1
//    }
//
//    func rightChildIndex(of index: Int) -> Int {
//        return index * 2 + 2
//    }
//}
//
//
//
//
//
//
//func getMinRooms(meetingTimings: [[Int]]) -> Int {
//
//    var meetings = meetingTimings.sorted(by: {$0[0] < $1[0]})
//    var maxheaps: [MaxHeap<Int>] = []
//    var check = 0
//
//    maxheaps.append(MaxHeap<Int>())
//    maxheaps[0].insert(meetings[0][1])
////    print ("pop = \(maxheaps[0].pop())")
//
//
//
//    for i in 1..<meetings.count{
//        for j in 0..<maxheaps.count{
//            guard let pop = maxheaps[j].pop() else {return 1}
//
//            if(pop <= meetings[i][0]){
////                print("in if 문")
////                print("maxheaps[\(j)] <- \(meetings[i])")
//                maxheaps[j].insert(meetings[i][1])
//                check = 1
//            }else{
//                maxheaps[j].insert(pop)
//            }
//        }
//        if(check != 1){
//            maxheaps.append(MaxHeap<Int>())
//            maxheaps[maxheaps.count-1].insert(meetings[i][1])
//        }else{
//            check = 0
//        }
//
//    }
//
//    return maxheaps.count
//}
//
//
//struct MaxHeap<Element: Comparable> {
//    var elements: [Element] = []
//
//    var isEmpty: Bool {
//        return elements.isEmpty
//    }
//
//    var count: Int {
//        return elements.count
//    }
//
//    mutating func insert(_ element: Element) {
//        elements.append(element)
//        siftUp(from: elements.count - 1)
//    }
//
//    mutating func siftUp(from index: Int) {
//        var child = index
//        var parent = parentIndex(of: child)
//
//        while child > 0 && elements[child] > elements[parent] {
//            elements.swapAt(child, parent)
//            child = parent
//            parent = parentIndex(of: child)
//        }
//    }
//
//    mutating func pop() -> Element? {
//        guard !isEmpty else {
//            return nil
//        }
//
//        elements.swapAt(0, count - 1)
//        let element = elements.removeLast()
//        siftDown(from: 0)
//        return element
//    }
//
//    mutating func siftDown(from index: Int) {
//        var parent = index
//
//        while true {
//            let leftChild = leftChildIndex(of: parent)
//            let rightChild = rightChildIndex(of: parent)
//            var candidate = parent
//
//            if leftChild < count && elements[leftChild] > elements[candidate] {
//                candidate = leftChild
//            }
//
//            if rightChild < count && elements[rightChild] > elements[candidate] {
//                candidate = rightChild
//            }
//
//            if candidate == parent {
//                return
//            }
//
//            elements.swapAt(parent, candidate)
//            parent = candidate
//        }
//    }
//
//    func parentIndex(of index: Int) -> Int {
//        return (index - 1) / 2
//    }
//
//    func leftChildIndex(of index: Int) -> Int {
//        return index * 2 + 1
//    }
//
//    func rightChildIndex(of index: Int) -> Int {
//        return index * 2 + 2
//    }
//}
//
//func getMinRooms(meetingTimings: [[Int]]) -> Int {
//    let meetings = meetingTimings.sorted(by: { $0[0] < $1[0] })
//    var maxHeaps: [MaxHeap<Int>] = []
//
//    for meeting in meetings {
//        var allocatedRoom = false
//
//        for i in 0..<maxHeaps.count {
//            if let endTime = maxHeaps[i].elements.first, endTime <= meeting[0] {
//                // 이전 회의가 끝난 시간보다 현재 회의의 시작 시간이 같거나 늦은 경우
//                // 기존 회의실을 이용
//                maxHeaps[i].insert(meeting[1])
//                allocatedRoom = true
//                break
//            }
//        }
//
//        if !allocatedRoom {
//            // 새로운 회의실 필요
//            var newHeap = MaxHeap<Int>()
//            newHeap.insert(meeting[1])
//            maxHeaps.append(newHeap)
//        }
//    }
//
//    return maxHeaps.count
//}








// 테스트 예시
let meetingTimings = [[1, 5], [2, 4], [3, 7], [6, 8], [7, 9]]
let maxRooms = getMinRooms(meetingTimings: meetingTimings)
print(maxRooms) // 출력: 3











//2번

/*


import Foundation


/*
 * Complete the 'numDuplicates' function below.
 *
 * The function is expected to return an INTEGER.
 * The function accepts following parameters:
 *  1. STRING_ARRAY name
 *  2. INTEGER_ARRAY price
 *  3. INTEGER_ARRAY weight
 */
 
 struct Item: Hashable{
     let name: String
     let price: Int
     let weight: Int
 }

func numDuplicates(name: [String], price: [Int], weight: [Int]) -> Int {
    var duplicates = [(name: String, price: Int, weight: Int)]()
    var seen = Set<String>()
    var seenItems = Set<Item>()
    
    for i in 0..<name.count{
        let item = Item(name: name[i], price: price[i], weight: weight[i])
        if seen.contains(item.name) && seenItems.contains(item){
            duplicates.append((item.name, item.price, item.weight))
        }else{
            seen.insert(item.name)
            seenItems.insert(item)
        }
    }
    return duplicates.count

}
let stdout = ProcessInfo.processInfo.environment["OUTPUT_PATH"]!
FileManager.default.createFile(atPath: stdout, contents: nil, attributes: nil)
let fileHandle = FileHandle(forWritingAtPath: stdout)!

guard let nameCount = Int((readLine()?.trimmingCharacters(in: .whitespacesAndNewlines))!)
else { fatalError("Bad input") }

var name = [String]()

for _ in 1...nameCount {
    guard let nameItem = readLine() else { fatalError("Bad input") }

    name.append(nameItem)
}

guard name.count == nameCount else { fatalError("Bad input") }

guard let priceCount = Int((readLine()?.trimmingCharacters(in: .whitespacesAndNewlines))!)
else { fatalError("Bad input") }

var price = [Int]()

for _ in 1...priceCount {
    guard let priceItem = Int((readLine()?.trimmingCharacters(in: .whitespacesAndNewlines))!)
    else { fatalError("Bad input") }

    price.append(priceItem)
}

guard price.count == priceCount else { fatalError("Bad input") }

guard let weightCount = Int((readLine()?.trimmingCharacters(in: .whitespacesAndNewlines))!)
else { fatalError("Bad input") }

var weight = [Int]()

for _ in 1...weightCount {
    guard let weightItem = Int((readLine()?.trimmingCharacters(in: .whitespacesAndNewlines))!)
    else { fatalError("Bad input") }

    weight.append(weightItem)
}

guard weight.count == weightCount else { fatalError("Bad input") }

let result = numDuplicates(name: name, price: price, weight: weight)

fileHandle.write(String(result).data(using: .utf8)!)
fileHandle.write("\n".data(using: .utf8)!)


*/


//MARK: 3번
/*
import Foundation



/*
 * Complete the 'findLargestSquareSize' function below.
 *
 * The function is expected to return an INTEGER.
 * The function accepts 2D_INTEGER_ARRAY samples as parameter.
 */

func findLargestSquareSize(samples: [[Int]]) -> Int {
    // Write your code here
    var matrix = samples
    
    let rows = matrix.count
    let cols = matrix[0].count
    var dp = [[Int]](repeating: [Int](repeating: 0, count: cols), count: rows)
    var maxLength = 0
    
    for i in 0..<rows{
        for j in 0..<cols{
            if matrix[i][j] == 1{
                if i==0 || j==0{
                    dp[i][j] = 1
                }else{
                    dp[i][j] = min(dp[i-1][j-1], dp[i][j-1], dp[i-1][j]) + 1
                }
                
                maxLength = max(maxLength, dp[i][j])
            }
        }
    }
    return maxLength


}

let stdout = ProcessInfo.processInfo.environment["OUTPUT_PATH"]!
FileManager.default.createFile(atPath: stdout, contents: nil, attributes: nil)
let fileHandle = FileHandle(forWritingAtPath: stdout)!

guard let samplesRows = Int((readLine()?.trimmingCharacters(in: .whitespacesAndNewlines))!)
else { fatalError("Bad input") }

guard let samplesColumns = Int((readLine()?.trimmingCharacters(in: .whitespacesAndNewlines))!)
else { fatalError("Bad input") }

var samples = [[Int]]()

for _ in 1...samplesRows {
    guard let samplesRowTemp = readLine()?.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression) else { fatalError("Bad input") }

    let samplesRow: [Int] = samplesRowTemp.split(separator: " ").map {
        if let samplesItem = Int($0) {
            return samplesItem
        } else { fatalError("Bad input") }
    }

    guard samplesRow.count == samplesColumns else { fatalError("Bad input") }

    samples.append(samplesRow)
}

guard samples.count == samplesRows else { fatalError("Bad input") }

let result = findLargestSquareSize(samples: samples)

fileHandle.write(String(result).data(using: .utf8)!)
fileHandle.write("\n".data(using: .utf8)!)
*/



//ict 인턴 4번 문자열 사이값 구하기
/*
func countIndicesBetweenProgrammerStrings(_ input: String) -> Int {
    var targetString = Array("programmer")
    var inputCharacters = Array(input)
    var startIndex = 0
    var endIndex = 0
    
    //처음부터 문자열 찾기
    for i in 0..<inputCharacters.count {
        if targetString.isEmpty {
            targetString = Array("programmer")
            startIndex = i
            break
        }
        
        let currentCharacter = inputCharacters[i]
        
        
        for j in 0..<targetString.count {
            if targetString[j] == currentCharacter {
                targetString.remove(at: j)
                break
            }
        }
    }
        
    
    for i in stride(from: inputCharacters.count-1, through: 0, by: -1){
        if targetString.isEmpty{
            endIndex = i
            break
        }
        let currentCharacter = inputCharacters[i]
        
        for j in 0..<targetString.count {
            if targetString[j] == currentCharacter {
                targetString.remove(at: j)
                break
            }
        }
    }
    
    return endIndex - startIndex + 1
}


let inputString = "progxrammerrxproxgrammer"
let count = countIndicesBetweenProgrammerStrings(inputString)
print(count)  // 6





//위 코드를 수정해서 inputCharacters[i] 의 값이 targetString 값에 포함되어 있으면 targetString 값에서 없애는 코드를 짜줘
//removeall 말고 하나의 문자만 없애는 코드로 짜줘
//Array<Character> 는 contain을 사용못해 어떻게 하면 사용할 수 있으까?
//Array<Character> 를 Array<String> 으로 변환하는 코드
//Swift 코딩테스트 contain 사용 못함
*/


//MARK: 5번

//func countWaysToPaintHouses(_ n: Int) -> Int {
//    guard n > 0 else { return 0 }
//
//    // 0: Red, 1: Blue, 2: Green
//    var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: 3), count: n)
//
//    // 초기 조건 설정
//    dp[0][0] = 1  // 첫 번째 집을 Red로 칠하는 경우
//    dp[0][1] = 1  // 첫 번째 집을 Blue로 칠하는 경우
//    dp[0][2] = 1  // 첫 번째 집을 Green으로 칠하는 경우
//
//    // 다이나믹 프로그래밍을 통해 경우의 수 계산
//    for i in 1..<n {
//        dp[i][0] = dp[i-1][1] + dp[i-1][2]  // i번째 집을 Red로 칠하는 경우
//        dp[i][1] = dp[i-1][0] + dp[i-1][2]  // i번째 집을 Blue로 칠하는 경우
//        dp[i][2] = dp[i-1][0] + dp[i-1][1]  // i번째 집을 Green으로 칠하는 경우
//    }
//
//    // 마지막 집을 칠하는 경우의 수 합산
//    let totalCount = dp[n-1][0] + dp[n-1][1] + dp[n-1][2]
//
//    return totalCount
//}
//
//// 테스트 예시
//let n = 6
//let ways = countWaysToPaintHouses(n)
//print(ways)  // 출력: 72

//func countWaysToPaintHouses(_ n: Int) -> Int {
//    guard n > 0 else { return 0 }
//
//    var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: 3), count: n)
//
//    // 첫 번째 집을 칠하는 경우의 수
//    dp[0][0] = 1  // 첫 번째 집을 Red로 칠하는 경우
//    dp[0][1] = 1  // 첫 번째 집을 Blue로 칠하는 경우
//    dp[0][2] = 1  // 첫 번째 집을 Green으로 칠하는 경우
//
//    // 두 번째 집부터 다이나믹 프로그래밍을 통해 경우의 수 계산
//    for i in 1..<n {
//        dp[i][0] = dp[i-1][1] + dp[i-1][2]  // i번째 집을 Red로 칠하는 경우
//        dp[i][1] = dp[i-1][0] + dp[i-1][2]  // i번째 집을 Blue로 칠하는 경우
//        dp[i][2] = dp[i-1][0] + dp[i-1][1]  // i번째 집을 Green으로 칠하는 경우
//    }
//
//    // 결과 계산
//    var totalCount = 0
//    for i in 0..<3 {
//        totalCount += dp[n-1][i]
//    }
//
//    return totalCount
//}
//
//// 테스트 예시
//let n = 2
//let ways = countWaysToPaintHouses(n)
//print(ways)  // 출력: 6
//
//let n2 = 4
//let ways2 = countWaysToPaintHouses(n2)
//print(ways2)  // 출력: 18
//
//let n3 = 6
//let ways3 = countWaysToPaintHouses(n3)
//print(ways3)  // 출력: 96

func countWaysToPaintHouses(_ n: Int) -> Int {
    if n <= 0 {
        return 0
    }
    
    // Base cases
    if n == 1 {
        return 3 // One house can be painted in 3 ways
    }
    
    if n == 2 {
        return 6 // Two houses can be painted in 6 ways (3 * 2)
    }
    
    // Create a 2D array to store the number of ways to paint the houses
    var dp = [[Int]](repeating: [Int](repeating: 0, count: 3), count: n + 1)
    
    // Initialize the first two houses
    dp[1][0] = 3 // First house can be painted in 3 ways
    dp[2][0] = 6 // Second house can be painted in 6 ways (3 * 2)
    
    for i in 3...n {
        // Calculate the number of ways to paint the i-th house based on the previous houses
        dp[i][0] = dp[i - 1][0] + dp[i - 1][1] + dp[i - 1][2]
        dp[i][1] = dp[i - 1][0] + dp[i - 1][2]
        dp[i][2] = dp[i - 1][0] + dp[i - 1][1]
    }
    
    // The total number of ways to paint the houses is the sum of the last row
    let totalWays = dp[n][0] + dp[n][1] + dp[n][2]
    
    return totalWays
}

// Example usage
let n = 6
let ways = countWaysToPaintHouses(n)
print("Number of ways to paint \(n) houses: \(ways)")








