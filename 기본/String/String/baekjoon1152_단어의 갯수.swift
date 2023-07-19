import Foundation
/*
 문제
 영어 대소문자와 공백으로 이루어진 문자열이 주어진다. 이 문자열에는 몇 개의 단어가 있을까? 이를 구하는 프로그램을 작성하시오. 단, 한 단어가 여러 번 등장하면 등장한 횟수만큼 모두 세어야 한다.

 입력
 첫 줄에 영어 대소문자와 공백으로 이루어진 문자열이 주어진다. 이 문자열의 길이는 1,000,000을 넘지 않는다. 단어는 공백 한 개로 구분되며, 공백이 연속해서 나오는 경우는 없다. 또한 문자열은 공백으로 시작하거나 끝날 수 있다.

 출력
 첫째 줄에 단어의 개수를 출력한다
 */

//MARK: 내 풀이
/*
print(readLine()!.split(separator: " ").count)
*/
/*
 내 풀이가 다른 풀이보다 연산속도가 느렸다
 이유는 split의 사용 떄문인듯 하다
 split은 문자열을 스캔 공백 확인 하위 배열을 만들어야하기 떄문.
 */


//MARK: 다른 풀이
/*
let inp = readLine()!
var ans = 0
var isChar = false
inp.forEach{
    if $0 != " "{
        if !isChar{
            ans += 1
            isChar = true
        }
    }else{
        isChar = false
    }
}
print(ans)
*/
