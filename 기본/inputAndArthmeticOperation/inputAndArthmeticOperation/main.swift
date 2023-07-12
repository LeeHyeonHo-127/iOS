import Foundation


//MARK: 1번
//print("Hello World!")


//MARK: 2번
//let intArr = readLine()!.split(separator: " ").map{Int($0)!}
//print(intArr[0] + intArr[1])

//MARK: 3번
//let intArr = readLine()!.split(separator: " ").map{Int($0)!}
//print(intArr[0] - intArr[1])

//MARK: 4번
//let intArr = readLine()!.split(separator: " ").map{Int($0)!}
//print(intArr[0] * intArr[1])

//MARK: 5번
//let intArr = readLine()!.split(separator: " ").map{Double($0)!}
//print(intArr[0] / intArr[1])


//MARK: 6번
//let intArr = readLine()!.split(separator: " ").map{Int($0)!}
//print(intArr[0] + intArr[1])
//print(intArr[0] - intArr[1])
//print(intArr[0] * intArr[1])
//print(intArr[0] / intArr[1])
//print(intArr[0] % intArr[1])

//MARK: 7번
//let stringArr = readLine()!
//print("\(stringArr)??!")

//MARK: 8번
//let bulGiYear = readLine()!
//print(Int(bulGiYear)! - 543)

//MARK: 9번
//let intArr = readLine()!.split(separator: " ").map{Int($0)!}
//print( (intArr[0] + intArr[1])%intArr[2] )
//print( ( (intArr[0] % intArr[2]) + (intArr[1] % intArr[2]) ) % intArr[2])
//print( (intArr[0] * intArr[1])%intArr[2] )
//print( ( (intArr[0] % intArr[2]) * (intArr[1] % intArr[2]) ) % intArr[2])



//MARK: 10번-1
//백준에서 String 값을 String.Element로 바꾸는 데에 에러가 발생해서 다시 풀었음

//let firstOperand = readLine()!.split(separator: " ").map{Int($0)!}
//let secondInput = readLine()!
//let secondOperand = secondInput.split(separator: "").map{Int($0)!}
//
//let firstOutput = firstOperand[0] * secondOperand[2]
//let secondOutput = firstOperand[0] * secondOperand[1]
//let thirdOutput = firstOperand[0] * secondOperand[0]
//let fourthOutput = (firstOutput) + (secondOutput * 10) + (thirdOutput * 100)
//
//print("\(firstOutput)\n\(secondOutput)\n\(thirdOutput)\n\(fourthOutput)")



//MARK: 10번-2
//let firstOperand = Int(readLine()!)!
//var secondInput = Int(readLine()!)!
//var secondOperand:[Int] = []
//
//var temp1 = secondInput/100
//secondOperand.append(temp1)
//secondInput -= (temp1*100)
//
//var temp2 = secondInput/10
//secondOperand.append(temp2)
//secondInput -= (temp2 * 10)
//
//secondOperand.append(secondInput)
//
//let firstOutput = firstOperand * secondOperand[2]
//let secondOutput = firstOperand * secondOperand[1]
//let thirdOutput = firstOperand * secondOperand[0]
//let fourthOutput = (firstOutput) + (secondOutput * 10) + (thirdOutput * 100)
//
//print("\(firstOutput)\n\(secondOutput)\n\(thirdOutput)\n\(fourthOutput)")


//MARK: 10번-3 : 깔끔한 코드
//let (f,s) = (Int(readLine()!)!,Int(readLine()!)!)
//for i in [s%10, s/10%10, s/100, s]{
//    print(i*f)
//}

//MARK: 11번
let intArr = readLine()!.split(separator: " ").map{Int($0)!}
print(intArr[0] + intArr[1] + intArr[2])




