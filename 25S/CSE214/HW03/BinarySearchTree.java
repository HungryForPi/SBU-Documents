import java.util.Queue;
import java.util.LinkedList;

public class BinarySearchTree {
    private class Node 
    {
        int key;
        Node left, right;
        
        public Node(int item) { key = item; left = right = null; }
    }
 
    private Node root;
    BinarySearchTree()
    {
        root = null;
        System.out.println("Binary search tree constructed and initialized\n");
    }
 
    public void insert(int key) { 
        System.out.println("Insert " + key);
        root = insertRecursive(root, key);
    }
    private Node insertRecursive(Node curr, int key) {
        if (curr == null){
            curr = new Node(key);
        }
        else {
            if (key < curr.key) curr.left = insertRecursive(curr.left, key);
            if (key > curr.key) curr.right = insertRecursive(curr.right, key);
        }
        return curr;
    }
    
    public void search(int key) {
        System.out.print("Search " + key + ": ");
        if (searchRecursive(root, key) != null)
            System.out.println("successful");
        else
            System.out.println("failure");
    }
    private Node searchRecursive(Node curr, int key) {
        if (curr == null) return curr;
        else if (key < curr.key) return searchRecursive(curr.left, key);
        else if (key > curr.key) return searchRecursive(curr.right, key);
        else return curr;
    }
    
    public void delete(int key) {
        System.out.println("Delete " + key);
        root = deleteRecursive(root, key);
    }
    private Node deleteRecursive(Node curr, int key) {
        // find node to be removed (if exists)
        if (curr == null) return null;
        else if (key < curr.key) curr.left = deleteRecursive(curr.left,key);
        else if (key > curr.key) curr.right = deleteRecursive(curr.right,key);

        // after exiting if (when curr.key = key) -- the actual removal
        if (curr.key == key) {
            if (curr.left == null) curr = curr.right;
            else if (curr.right == null) curr = curr.left;
            else {
                curr.key = maximumRecursive(curr.left).key;
                curr.left = deleteRecursive(curr.left, curr.key);
            }
        }
        return curr;
    }
    
    public void preorder() {
        System.out.print("Preorder traversal: ");
        preorderRecursive(root);
        System.out.println();
    }
    private void preorderRecursive(Node curr) {
        if (curr != null) {
            System.out.print(curr.key + " ");
            preorderRecursive(curr.left);
            preorderRecursive(curr.right);
        }
    }
 
    public void inorder() {
        System.out.print("Inorder traversal: ");
        inorderRecursive(root);
        System.out.println();
    }
    private void inorderRecursive(Node curr) {
        if (curr != null) {
            inorderRecursive(curr.left);
            System.out.print(curr.key + " ");
            inorderRecursive(curr.right);
        }
    }
    
    public void postorder() {
        System.out.print("Postorder traversal: ");
        postorderRecursive(root);
        System.out.println();
    }
    private void postorderRecursive(Node curr) {
        if (curr != null) {
            postorderRecursive(curr.left);
            postorderRecursive(curr.right);
            System.out.print(curr.key + " ");
        }
    }
    
    public void levelorder() {
        System.out.print("Levelorder traversal: ");
        Queue<Node> Q = new LinkedList<>();
        Node curr = null;
        Q.add(root);
        while (!Q.isEmpty()){
            curr = Q.remove();
            System.out.print(curr.key + " ");
            if (curr.left != null) Q.add(curr.left);
            if (curr.right != null) Q.add(curr.right);
        }
        System.out.println();
    }
    
    public void height() {
        System.out.println("Height: " + heightRecursive(root));
    }
    private int heightRecursive(Node curr) {
        if (curr == null) return 0;
        return 1 + Math.max(heightRecursive(curr.left),heightRecursive(curr.right));
    }
    
    public void countNodes() {
        System.out.println("Count nodes: " + countNodesRecursive(root));
    }
    private int countNodesRecursive(Node curr) {
        if (curr == null) return 0;
        // curr is not null, so add 1 to count curr
        return 1 + countNodesRecursive(curr.left) + countNodesRecursive(curr.right);
    }
    
    public void maximum() {
        if (root == null)
            System.out.println("Maximum value doesn't exist for an empty tree");
        else
            System.out.println("Maximum value: " + maximumRecursive(root).key);
    }
    private Node maximumRecursive(Node curr) { // should be rightmost node (just go right !)
        if (curr.right == null) return curr;
        else return maximumRecursive(curr.right);
    }
 
    public static void main(String[] args)
    {
        BinarySearchTree tree = new BinarySearchTree();
        
        /* Construct the following binary search tree
              50
           /     \
          30      70
         /  \    /  \
       20   40  60   80 */
        tree.insert(50);
        tree.insert(30);
        tree.insert(20);
        tree.insert(40);
        tree.insert(70);
        tree.insert(60);
        tree.insert(80);
        tree.insert(30);
        tree.insert(70);
        tree.insert(40);
        System.out.println();
 
        tree.preorder();
        tree.inorder();
        tree.postorder();
        tree.levelorder();
        System.out.println();
        
        tree.height();
        tree.countNodes();
        tree.maximum();
        System.out.println();
        
        tree.delete(60);
        tree.delete(30);
        tree.delete(50);
        tree.delete(10);
        System.out.println();
 
        tree.preorder();
        tree.inorder();
        tree.postorder();
        tree.levelorder();
        System.out.println();
        
        tree.search(70);
        tree.search(50);
        tree.search(10);
        System.out.println();
    }
}