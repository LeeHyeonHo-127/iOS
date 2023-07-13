//MARK: 나의 풀이
//import Foundation
//
//let input = Int(readLine()!)!
//if(input >= 90){
//    print("A")
//}else if(input<90 && input>=80){
//    print("B")
//}else if(input<80 && input>=70){
//    print("C")
//}else if(input<70 && input>=60){
//    print("D")
//}else{
//    print("F")
//}


//MARK: 깔끔한 코드
//import Foundation
//
//
//let n = Int(readLine()!)!
//
//func gradeGen(Score score: Int)-> String{
//    let scores = ["D", "C", "B", "A", "A"] //마지막은 100점을 위함
//    let n = score/10 - 6
//
//    if (score<60){return "F"}
//
//    return (scores[n])
//}
//print(gradeGen(Score: n))
