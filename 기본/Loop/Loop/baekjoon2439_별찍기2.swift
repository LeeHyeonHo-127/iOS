/*
 문제
 첫째 줄에는 별 1개, 둘째 줄에는 별 2개, N번째 줄에는 별 N개를 찍는 문제

 하지만, 오른쪽을 기준으로 정렬한 별(예제 참고)을 출력하시오.

 입력
 첫째 줄에 N(1 ≤ N ≤ 100)이 주어진다.

 출력
 첫째 줄부터 N번째 줄까지 차례대로 별을 출력한다
 
 예제 입력
 5
 예제 출력
     *
    **
   ***
  ****
 *****
 
 */

//MARK: 내 풀이
/*
import Foundation

if let n = Int(readLine()!){
    for i in 1...n{
        for j in stride(from: n, through: 1, by: -1){
            if j > i{
                print(" ", terminator: "")
            }else{
                print("*", terminator: "")
            }
        }
        print()
    }
}
*/

//MARK: 깔끔한 풀이
/*
 import Foundation
 
 let n = Int(readLine()!)!
 
 Array(0..<n).reversed().forEach{
 print(String(repeating: " ", count: $0), terminator: "")
 print(String(repeating: "*", count: n-$0))
 }
 */
