import Foundation

/*
 문제
 예제를 보고 규칙을 유추한 뒤에 별을 찍어 보세요.

 입력
 첫째 줄에 N(1 ≤ N ≤ 100)이 주어진다.

 출력
 첫째 줄부터 2×N-1번째 줄까지 차례대로 별을 출력한다.
 */

//MARK: 내 코드
/*
let n = Int(readLine()!)!

for line in 1...n{
    print(String(repeating: " ", count: n-line), terminator: "")
    print(String(repeating: "*", count: line*2-1))
}

for line in 1..<n{
    print(String(repeating: " ", count: line), terminator: "")
    print(String(repeating: "*", count: (n-line)*2-1))
}
*/

/*
let n = Int(readLine()!)!

for line in 1...n{
    print(String(repeating: " ", count: n-line)+String(repeating: "*", count: line*2-1))
}

for line in 1..<n{
    print(String(repeating: " ", count: line) + String(repeating: "*", count: (n-line)*2-1))
}
*/
