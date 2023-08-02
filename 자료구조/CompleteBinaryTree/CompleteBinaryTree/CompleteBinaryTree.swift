import Foundation

struct CompleteBinaryTree<T: Comparable>{
    var root: TreeNode<T>?
    
    private func add(newNode: TreeNode<T>){
        var queue: Queue<TreeNode<T>> = Queue<TreeNode<T>>()
        queue.inqueue(data: root!)
        while(!queue.isEmpty()){
            let now = queue.dequeue()
            if now.leftChild == nil{
                now.leftChild = newNode
                return
            }
            if now.rightChild == nil{
                now.rightChild = newNode
                return
            }
            queue.inqueue(data: now.leftChild!)
            queue.inqueue(data: now.rightChild!)
        }
    }
    mutating func add(data:T){
        if root == nil{
            self.root = TreeNode(data: data)
        }else{
            self.add(newNode: TreeNode(data: data))
        }
    }
    func printInorder() {
        print("\n==== Inorder ====")
        self.printInorder(node: self.root)
        print("\n")
    }
    
    func printPreorder() {
        print("\n==== Preorder ====")
        self.printPreorder(node: self.root)
        print("\n")
    }
    
    func printPostorder() {
        print("\n==== Postorder ====")
        self.printPostorder(node: self.root)
        print("\n")
    }
    //전위 순회 VLR
    private func printPreorder(node: TreeNode<T>?) {
        guard let node = node else { return }
        print(node.data, terminator: " ")
        self.printPreorder(node: node.leftChild)
        self.printPreorder(node: node.rightChild)
    }
    
    //중위 순회 LVR
    private func printInorder(node: TreeNode<T>?) {
        guard let node = node else { return }
        self.printInorder(node: node.leftChild)
        print(node.data, terminator: " ")
        self.printInorder(node: node.rightChild)
    }
    
    //후위 순회 LRV
    private func printPostorder(node: TreeNode<T>?) {
        guard let node = node else { return }
        self.printPostorder(node: node.leftChild)
        self.printPostorder(node: node.rightChild)
        print(node.data, terminator: " ")
    }
    
    func printTree(){
        print(root!.asString)
    }
    
    
}
