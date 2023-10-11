/*
 문제
 땅 위에 달팽이가 있다. 이 달팽이는 높이가 V미터인 나무 막대를 올라갈 것이다.

 달팽이는 낮에 A미터 올라갈 수 있다. 하지만, 밤에 잠을 자는 동안 B미터 미끄러진다. 또, 정상에 올라간 후에는 미끄러지지 않는다.

 달팽이가 나무 막대를 모두 올라가려면, 며칠이 걸리는지 구하는 프로그램을 작성하시오.

 입력
 첫째 줄에 세 정수 A, B, V가 공백으로 구분되어서 주어진다. (1 ≤ B < A ≤ V ≤ 1,000,000,000)

 출력
 첫째 줄에 달팽이가 나무 막대를 모두 올라가는데 며칠이 걸리는지 출력한다.
 */

import Foundation

//MARK: 내 풀이
/*
let input = readLine()!.split(separator: " ").map{Int($0)!}
let up = input[0]
let down = input[1]
let length = input[2]

if(up == length){
    print(1)
}else if(up-down < length - up){
    if((length-up) % (up-down) == 0){
        print( ((length-up) / (up-down)) + 1)
    }else{
        print( ((length-up) / (up-down)) + 2)
    }
}else{
    print(2)
}
*/

//MARK: 깔끔한 풀이
/*
 var r=readLine()!.split{$0==" "}.map{Int($0)!};print(1+(r[2]-r[1]-1)/(r[0]-r[1]))
 */
