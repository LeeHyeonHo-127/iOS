import UIKit

class myConcept{
    var myconcepts: [String]? = [String]()
    
    subscript(index:Int) -> String?{
        get{
            if(index <= myconcepts!.count){
                return myconcepts![index]
            }else{
                return nil
            }
        }
        set(newValue){
            myconcepts![index] = newValue ?? "error"
        }
       
    }
}

var myConcept2: myConcept = myConcept()

myConcept2.myconcepts?.append("최유진")
myConcept2.myconcepts?.append("권지용")
myConcept2.myconcepts?.append("Beenzino")

myConcept2[1] = "권지용용"
print(myConcept2[1])
