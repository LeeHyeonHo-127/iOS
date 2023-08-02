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
    
    func nodeCount(node: TreeNode<T>?)->Int{
        if node == nil{
            return 0
        }
        else {
            return nodeCount(node: node?.leftChild) + nodeCount(node: node?.rightChild) + 1
            
        }
    }
    
    func leafNodeCount(node: TreeNode<T>?)->Int{
        if node == nil{
            return 0
        }
        if node!.rightChild == nil && node!.leftChild == nil{
            return 1
        }else{
            return leafNodeCount(node: node?.leftChild) + leafNodeCount(node: node?.rightChild)
        }
    }
    
    func treeHeight(node: TreeNode<T>?)->Int{
        return treeHeightInner(node: node) - 1
    }
    
    func treeHeightInner(node: TreeNode<T>?)->Int{
        if node == nil{
            return 0
        }else{
            if(treeHeightInner(node: node?.leftChild) > treeHeightInner(node: node?.rightChild)){
                return treeHeightInner(node: node?.leftChild) + 1
            }else{
                return treeHeightInner(node: node?.rightChild) + 1
            }
        }
    }
    
    func printTree(){
        print(root!.asString)
    }
    
    
}
