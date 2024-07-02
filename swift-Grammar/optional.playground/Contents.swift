import UIKit

var name: String?

if name == .some("Hyunho") {print(name)}
if name == .none {print("nil")}


var numbers: [Int?] = [nil, 30, 40, nil, 150]

for item in numbers{
    switch item{
    case .some(let someValue) where someValue > 50:
        print("큰 값 : \(someValue)")
    case .some(let someValue) where someValue < 50:
        print("작은 값 : \(someValue)")
    case .none:
        print("nil")
    default:
        break;
    }
}

/*
 nil
 작은 값 : 30
 작은 값 : 40
 nil
 큰 값 : 150
 */


//MARK: - 강제 추출

var blank: String?

//var name = blank!
//error!

//MARK: - 옵셔널 바인딩

var myName: String? = nil

if let name = myName{
    print(name)
}


//MARK: - 암시적 추출 옵셔널


var Hyunho: String! = "현호"

print(Hyunho)//Optional("현호")

Hyunho = nil

//Hyunho.isEmpty //오류 발생

//MARK: - 옵셔널 체이닝

class Person{
    var name: String?
    var laptop: MacBook?
    var job: String?
    
    init(name:String, laptop: MacBook, job: String){
        self.name = name
        self.laptop = laptop
        self.job = job
    }
}


class MacBook{
    var m1Chip: Bool?
    var intelChip: Bool?
    
}

//func showMacBookChipWithOptionalChaning(owner: Person?){
//    if let m1 = owner?.laptop?.m1Chip{
//        print("\(owner.name)의 맥북은 m1Chip이다")
//    }else{
//        print("\(owner.name)의 맥북은 intelChip이다.")
//    }
//}

func showMacBookChipWithOptionalChaning(owner: Person?){
    if let MacbookChip = owner?.laptop?.m1Chip{
        print("\(owner?.name)의 맥북은 m1Chip 맥북 입니다.")
    }else if let MacbookChip = owner?.laptop?.intelChip{
        print("\(owner?.name)의 맥북은 intel 맥북 입니다.")
    }else{
        print("\(owner?.name)의 맥북 cpu를 알 수 없습니다.")
    }
}

var hyunhoMac: MacBook = MacBook()
hyunhoMac.m1Chip = true

var hyunho: Person? = Person(name: "Hyunho", laptop: hyunhoMac, job: "Student")

showMacBookChipWithOptionalChaning(owner: hyunho)
//Optional(__lldb_expr_33.Person)의 맥북은 m1Chip 맥북 입니다.


    
