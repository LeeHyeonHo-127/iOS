import Foundation

class Node<T: Equatable>{
    var data: T?
    var next: Node?

    init(data: T?, next: Node? = nil){
        self.data = data
        self.next = next
    }
}

class LinkedList<T: Equatable>{
    private var head: Node<T>?
    
    func append(data: T){
        if head == nil{
            head = Node(data: data, next: nil)
            print("append 되었습니다")
            return
        }
        var node = head
        
        while(node?.next != nil){
            node = node?.next
        }
        node?.next = Node(data: data, next: nil)
        print("append 되었습니다")
        return
    }
    
    func insert(data: T, index: Int){
        var node = head
        if (head == nil){
            head = Node(data: data, next: nil)
            print("빈 연결리스트입니다. head에 해당 data를 저장합니다")
        }
        
        for _ in 0..<index-1{
            node = node?.next
        }
        print("insert 되었습니다.")
        var nextNode = node?.next
        node?.next = Node(data: data, next: nextNode)
    }
    
    func removeLast(){
        var node = head
        if (head == nil){
            print("빈 연결리스트입니다")
            return
        }
        if (head?.next == nil){
            head = nil
            print("헤드 노드가 삭제되었습니다")
            return
        }
        while(node?.next?.next != nil){
            node = node?.next
        }
        node?.next = nil
        return
    }
    
    func remove(index: Int){
        var node = head
        if head == nil{
            print("빈 연결리스트 입니다")
            return
        }
        
        for _ in 0..<index-1{
            if(node?.next?.next == nil){ break }
            node = node?.next
        }
        node?.next = node?.next?.next
    }
    
    func search(data: T) -> Node<T>? {
        var node = head
        if head == nil{
            print("빈 연결리스트입니다")
            return nil
        }
        while(node?.data != data || node?.next != nil){
            node = node?.next
        }
        if (node?.data != data){
            print("찾으시는 데이터는 해당 연결리스트에 없습니다")
            return nil
        }
        return node
    }
    
    func search(index: Int) -> Node<T>?{
        var node = head
        if head == nil{
            print("빈 연결리스트입니다")
            return nil
        }
        for i in 0..<index{
            print(node?.data)
            node = node?.next
        }
        return node
    }
    
    func printAllNode(){
        var node = head
        if node == nil{
            print("빈 연결리스트입니다")
            return
        }
        while (node != nil){
            if let data = node?.data {
                print(data, terminator: " ")
            }
            node = node?.next
        }
        print()
        return
        
    }
}

var linkedList: LinkedList<Int> = LinkedList<Int>()
//append
linkedList.append(data: 1)
linkedList.append(data: 2)
linkedList.append(data: 3)
linkedList.printAllNode()// 1 2 3
//삽입
linkedList.insert(data: 4, index: 2)
linkedList.printAllNode() //1 2 4 3
//removeLast
linkedList.removeLast()
linkedList.printAllNode() //1 2 4 3
//remove
linkedList.remove(index: 1)
linkedList.printAllNode() //1 2 4 3
//search
print(linkedList.search(index: 0)?.data) //1
