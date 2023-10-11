import Foundation
/*
 문제
 알파벳 대소문자로 된 단어가 주어지면, 이 단어에서 가장 많이 사용된 알파벳이 무엇인지 알아내는 프로그램을 작성하시오. 단, 대문자와 소문자를 구분하지 않는다.

 입력
 첫째 줄에 알파벳 대소문자로 이루어진 단어가 주어진다. 주어지는 단어의 길이는 1,000,000을 넘지 않는다.

 출력
 첫째 줄에 이 단어에서 가장 많이 사용된 알파벳을 대문자로 출력한다. 단, 가장 많이 사용된 알파벳이 여러 개 존재하는 경우에는 ?를 출력한다.
*/

//MARK: 내 풀이
/*
var word = readLine()!
var alphabet = [Int].init(repeating: 0, count: 26)
var count = 0

word.forEach{
    let n = $0.asciiValue! > 96 ? $0.asciiValue!-97 : $0.asciiValue!-65
    alphabet[Int(n)] += 1
}

alphabet.forEach{
    if($0 == alphabet.max()){
        count += 1
    }
}

if(count>1){
    print("?")
}else{
    var index = Int(exactly: alphabet.firstIndex(of: alphabet.max()!)!)!
    print(String(UnicodeScalar(65+index)!))
}
*/

//MARK: 다른 풀이
/*
var word = readLine()!
var alphabet = [Int].init(repeating: 0, count: 26)
var count = 0

word.forEach{
    let n = $0.asciiValue! > 96 ? $0.asciiValue!-97 : $0.asciiValue!-65
    alphabet[Int(n)] += 1
}

var max = alphabet.max()!
if(alphabet.firstIndex(of: max) == alphabet.lastIndex(of: max)){
    print("?")
}else{
    var index = Int(exactly: alphabet.firstIndex(of: alphabet.max()!)!)!
    print(String(UnicodeScalar(65+index)!))
}
*/
