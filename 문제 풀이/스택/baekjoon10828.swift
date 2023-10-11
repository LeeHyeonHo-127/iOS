import Foundation

enum stackFunc: String{
    case push = "push"
    case pop = "pop"
    case size = "size"
    case empty = "empty"
    case top = "top"
}

func convertToEnum(from string: String) -> stackFunc? {
    return stackFunc(rawValue: string)
}

let num = Int(readLine()!)!
var stack = StackStruct()

for i in 0..<num{
    let input = readLine()!.split(separator: " ").map{String($0)}
    
    var inputFunc = stackFunc(rawValue: input[0])
    
    switch inputFunc{
    case .push:
        stack.push(item: Int(input[1])!)
    case .pop:
        print(stack.pop())
    case .size:
        print(stack.size())
    case .empty:
        print(stack.isEmpty())
    case .top:
        print(stack.top())
    default :
        print("지정되지 않은 명령어입니다")
    }

    
}


struct StackStruct{
    
    var array:[Int] = []

    
    mutating func push(item: Int){
        array.append(item)
    }

    mutating func pop() -> Int {
        if (array.isEmpty == true) {
            return -1
        }
        else{
            return array.removeLast()
        }
    }
    
    func size() -> Int {
        return array.count
    }
    
    func isEmpty() -> Int {
        if array.isEmpty {return 1}
        else {return 0}
    }
    
    func top() -> Int {
        if array.isEmpty {return -1 }
        
        else {
            return array.last!
        }
        
    }
}






