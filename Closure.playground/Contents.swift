import UIKit


//MARK: - 클로저의 사용
//
//let sum :(Int, Int) -> Int = {(a:Int, b:Int) in
//    return a + b
//}
//
//var sumResult = sum(1,2)
//print(sumResult) //3


//MARK: - 함수의 전달인자로서의 클로저 사용

//let add :(Int, Int) -> Int = {(a:Int, b:Int) in
//    return a + b
//}
//
//let subtract: (Int,Int) -> Int = {(a:Int, b:Int) in
//    return a-b
//}
//
//let divide: (Int,Int) -> Int = {(a:Int, b:Int) in
//    return a/b
//}
//
//let multitple: (Int,Int) -> Int = {(a:Int, b:Int) in
//    return a*b
//}
//
//func calculate(a: Int, b: Int, method: (Int,Int)->Int) -> Int{
//    return method(a,b)
//}
//
//var calculated = calculate(a: 5, b: 6, method: multitple)
//print(calculated) //30

//MARK: - 다양한 클로저표현

//후행 클로저

//func travel(action: ()->Void){
//    print("나는 나갈 준비를 하고 있다")
//    action()
//    print("도착!!!")
//}
//
//travel() {
//    print("나는 기차를 타고 강릉으로 기동하고 있다.")
//}
////나는 나갈 준비를 하고 있다
////나는 기차를 타고 강릉으로 기동하고 있다.
////도착!!!
//
//travel{ //다른 매개변수가 없으므로 () 생략 가능
//    print("나는 기차를 타고 강릉으로 기동하고 있다.")
//}
////나는 나갈 준비를 하고 있다
////나는 기차를 타고 강릉으로 기동하고 있다.
////도착!!!
//
//
//
////후행 클로저2 (후행크로저 유무 비교)
//
//func repeatMethod(repeatnum:Int, Method:() -> Void){
//    for _ in 1...repeatnum{
//        Method()
//    }
//}
//
////후행클로저를 사용하지 않은 예제
//repeatMethod(repeatnum: 3, Method: {
//    print("HELLO WORLD")
//})
////HELLO WORLD
////HELLO WORLD
////HELLO WORLD
//
////후행클로저를 사용한 예제
//repeatMethod(repeatnum: 3){
//    print("HELLO WORLD!!!")
//}
////HELLO WORLD!!!
////HELLO WORLD!!!
////HELLO WORLD!!!

//반환 타입 생략

func calculate(a: Int, b: Int, method: (Int,Int)->Int) -> Int{
    return method(a,b)
}

var result = calculate(a: 3, b: 5, method: {(left: Int, right: Int) in
    return left + right //8
})


//단축인자 이름


var result2 = calculate(a: 10, b: 10, method:{
    return $0 * $1 //100
})

//후행클로저를 사용한 단축인자

var result3 = calculate(a: 10, b: 10){
    return $0 * $1 //100
}


//암시적 반환 표현
var result4 = calculate(a: 10, b: 10){ $0 * $1 }


//MARK: - 고차 함수
//map
let numbers: [Int] = [0, 1, 2, 3, 4]
 
var doubledNumbers: [Int] = [Int]()
var string: [String] = [String]()
 

doubledNumbers = numbers.map({$0 * 2})
print(doubledNumbers) //[0, 2, 4, 6, 8]
string = numbers.map{"\($0)"}
print(string) //["0", "1", "2", "3", "4"]


//filter

var over3: [Int] = [Int]()
over3 = numbers.filter{$0>3}
print(over3) //4

//reduce

let number = [1, 2, 3, 4, 5]
 
let sum1 = number.reduce(0) { (result:Int, element: Int) -> Int in return result + element }
print(sum1) //15
 
//추론으로 생략 가능
let sum2 = number.reduce(0) { (result, element) in result + element }
print(sum2) //15
 
let sum3 = number.reduce(1) {$0 + $1}
print(sum3) //16
 
