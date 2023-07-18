import Foundation

/*
 문제
 총 N개의 정수가 주어졌을 때, 정수 v가 몇 개인지 구하는 프로그램을 작성하시오.

 입력
 첫째 줄에 정수의 개수 N(1 ≤ N ≤ 100)이 주어진다. 둘째 줄에는 정수가 공백으로 구분되어져있다. 셋째 줄에는 찾으려고 하는 정수 v가 주어진다. 입력으로 주어지는 정수와 v는 -100보다 크거나 같으며, 100보다 작거나 같다.

 출력
 첫째 줄에 입력으로 주어진 N개의 정수 중에 v가 몇 개인지 출력한다.
 */

//MARK: 내 풀이
/*
var arrayCount = Int(readLine()!)!
var count = 0
var input = readLine()!.split(separator: " ").map{Int($0)!}
var number = Int(readLine()!)!

for i in 0..<arrayCount{
    if input[i] == number{
        count+=1
    }
}
print(count)
*/

//MARK: 깔끔한 풀이
/*
if let _ = readLine(){
    if let input = readLine(), let v = readLine(){
        let values = input.split(separator: " ").map{Int($0) ?? 0}.filter {$0 == Int(v) ?? 0}
        print(values.count)
    }
}
*/
