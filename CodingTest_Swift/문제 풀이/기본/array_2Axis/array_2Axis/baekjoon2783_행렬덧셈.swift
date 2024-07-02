/*
 문제
 N*M크기의 두 행렬 A와 B가 주어졌을 때, 두 행렬을 더하는 프로그램을 작성하시오.

 입력
 첫째 줄에 행렬의 크기 N 과 M이 주어진다. 둘째 줄부터 N개의 줄에 행렬 A의 원소 M개가 차례대로 주어진다. 이어서 N개의 줄에 행렬 B의 원소 M개가 차례대로 주어진다. N과 M은 100보다 작거나 같고, 행렬의 원소는 절댓값이 100보다 작거나 같은 정수이다.

 출력
 첫째 줄부터 N개의 줄에 행렬 A와 B를 더한 행렬을 출력한다. 행렬의 각 원소는 공백으로 구분한다.
 */

//MARK: 내 풀이
/*
import Foundation

let nm = readLine()!.split(separator: " ").map{Int($0)!}
var array1:[[Int]] = []
var array2:[[Int]] = []

for i in 0..<nm[0]{
    let temp = readLine()!.split(separator: " ").map{Int($0)!}
    array1.append(temp)
}

for i in 0..<nm[0]{
    let temp = readLine()!.split(separator: " ").map{Int($0)!}
    array2.append(temp)
}
for i in 0..<nm[0]{
    for j in 0..<nm[1]{
        print("\(array1[i][j] + array2[i][j])", terminator: " ")
    }
    print()
}
*/

