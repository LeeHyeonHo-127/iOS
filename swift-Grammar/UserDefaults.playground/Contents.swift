import UIKit

var number:Dictionary = ["hyunho":"010-7520-3758", "HaeIn":"010-3600-0907"]
UserDefaults.standard.set(number, forKey: "전화번호")
var numberBackUp = UserDefaults.standard.dictionary(forKey: "전화번호")
print(numberBackUp) //Optional(["hyunho": 010-7520-3758, "HaeIn": 010-3600-0907])

