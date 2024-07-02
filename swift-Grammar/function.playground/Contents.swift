import UIKit

//MARK: -함수의 특징, override, overloading


//overloading
func printBrand (brand1 : String){
    print(brand1)
}

func printBrand (brand2 : String){
    print(brand2)
}

printBrand(brand1: "nike")
printBrand(brand2: "addidas")

//nike
//addidas


//override

func printBrand (brand1 : String, brand2 : String){
    print(brand1, brand2)
}

printBrand(brand1: "Channel", brand2: "LV")

//Channel LV

//MARK: - returen 키워드 없이 함수 사용

func hello (name: String) -> String{
    "HelloWorld! My name is \(name)"
}

var starting : String = hello(name: "hyunho")
print(starting)
//HelloWorld! My name is hyunho



//MARK: - 매개변수 여러 개 사용하기


func welcome(myname : String, yourname : String) -> String{
    "안녕하세요 \(yourname)님, 제 이름은 \(myname)이라고 합니다"
}

print(welcome(myname: "hyunho", yourname: "hyunbin"))
//안녕하세요 hyunbin님, 제 이름은 hyunho이라고 합니다

//MARK: - 매개변수 레이블 사용하기

func welcome2(from myname : String, to yourname : String) -> String{
    "안녕하세요 \(yourname)님, 제 이름은 \(myname)이라고 합니다"
}

print(welcome2(from: "hyunho", to: "hyunbin"))
//안녕하세요 hyunbin님, 제 이름은 hyunho이라고 합니다


//MARK: - 와일드카드 식별자

func welcome3(_ myname : String, _ yourname : String) -> String{
    "안녕하세요 \(yourname)님, 제 이름은 \(myname)이라고 합니다"
}

print(welcome3("hyunho", "hyunbin"))
//안녕하세요 hyunbin님, 제 이름은 hyunho이라고 합니다


//MARK: - 매개변수 기본값 사용


func welcome4(_ myname : String, _ yourname : String, times : Int = 3) -> String{
    var result:String = ""
    
    for _ in 0..<times{
        result += "안녕하세요 \(yourname)님, 제 이름은 \(myname)이라고 합니다\n"
    }
    
    return result
}

print(welcome4("hyunho", "haein"))
//안녕하세요 haein님, 제 이름은 hyunho이라고 합니다
//안녕하세요 haein님, 제 이름은 hyunho이라고 합니다
//안녕하세요 haein님, 제 이름은 hyunho이라고 합니다



//MARK: - 가변 매개변수


func helloFriends(frineds : String...){
    var result: String = ""
    
    for name in frineds{
        result += "안녕 \(name)아\n"
    }
    
    print(result)
}

helloFriends(frineds: "현호","짱구","철수")
//안녕 현호아
//안녕 짱구아
//안녕 철수아


//MARK: - 데이터 타입으로서의 함수


//typealias CalculateTwoInts = (Int,Int) -> Int

//func addTwoInts(a: Int, b: Int) -> Int{
//    return a+b
//}

//func multiplyTwoInts(a: Int, b: Int) -> Int{
//    return a*b
//}

var mathFunction : CalculateTwoInts = addTwoInts
print(mathFunction(1,2)) //3

mathFunction = multiplyTwoInts
print(mathFunction(1,2)) //2


//MARK: - 매개변수로 함수르 전달받는 함수

//typealias CalculateTwoInts = (Int,Int) -> Int
//
//func addTwoInts(a: Int, b: Int) -> Int{
//    return a+b
//}
//
//func printMathResult(mathFunction: CalculateTwoInts, a: Int, b: Int){
//    print(mathFunction(a,b))
//}

//printMathResult(mathFunction: addTwoInts, a: 1, b: 2) //3


//MARK: - 반환 인자로 함수를 사용하는 경우


typealias CalculateTwoInts = (Int,Int) -> Int

func addTwoInts(a: Int, b: Int) -> Int{
    return a+b
}

func multiplyTwoInts(a: Int, b: Int) -> Int{
    return a*b
}

func printMathResult(mathFunction: CalculateTwoInts, a: Int, b: Int){
    print(mathFunction(a,b))
}

func chooseMathFunction(toAdd: Bool) -> CalculateTwoInts{
    return toAdd ? addTwoInts : multiplyTwoInts
}

printMathResult(mathFunction: chooseMathFunction(toAdd: false), a: 2, b: 5) //10



//MARK: - 두 개 이상의 값을 반환하는 함수

func getName() -> (first: String, last: String){
    (first: "Hyunho", last: "Lee")
}

let userName = getName()
print(userName.first) //Hyunho
print(userName.last) //Lee
