//Hash Table 구현

import Foundation

var hashTable:[String] = .init(repeating: "", count: 3)

func hash(key: Int) -> Int{
    return key%3
}

func updataValue(value: String, key: String){
    guard let key = UnicodeScalar(key)?.value else {return}
    let hashAddress = hash(key: Int(exactly: key)!)
    hashTable[hashAddress] = value
}

func getValue(key: String) -> String{
    guard let key = UnicodeScalar(key)?.value else {return ""}
    let hashAddress = hash(key: Int(exactly: key)!)
    return hashTable[hashAddress]
}


updataValue(value: "재석", key: "유")
print(getValue(key: "유")) //재석
