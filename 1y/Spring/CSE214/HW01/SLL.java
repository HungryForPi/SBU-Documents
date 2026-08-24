class SinglyLinkedList {
    // Node class to represent each element in the list
    private static class Node {
        int data;
        Node next;

        Node(int data) {
            this.data = data;
            this.next = null;
        }
    }

    // Instance variables for the linked list
    private Node head; // Points to the first node
    private Node tail; // Points to the last node
    private int size;  // Number of elements in the list

    // Constructor to initialize an empty list
    public SinglyLinkedList() {
        this.head = null;
        this.tail = null;
        this.size = 0;
    }

    // Method to add an element at the end of the list
    public void addLast(int data) {
        Node newNode = new Node(data);
        if (head == null) {
            head = newNode;
            tail = newNode;
        } else {
            tail.next = newNode;
            tail = newNode;
        }
        size++;
    }

    // Method to add an element at the beginning of the list
    public void addFirst(int data) {
        Node newNode = new Node(data);
        newNode.next = head;
        head = newNode;
        if (tail == null) {
            tail = newNode;
        }
        size++;
    }

    // Method to print all keys at even positions
    public void printEvenPositions() {
        String evenIndices = "";
        Node curnode = null;
        if (size >= 2) { // so that head.next is never null
            curnode = head.next; // position 2
        }
        for (int i = 2; i <= size; i+= 2) {
            evenIndices += curnode.data + " ";
            if (i < size - 1) curnode = curnode.next.next; // otherwise we are at the End
        }
        System.out.println(evenIndices);
    }

    // Method to search for a given key and return the index (1-based)
    public int search(int key) {
        Node curnode = head;
        for (int i = 1; i <= size; i++) { // i keeps track of our index
            if (curnode.data == key) return i;
            curnode = curnode.next;
        }
        return -1; // if we have left the loop then we found nothing
        // note that the loop is automatically skipped if size = 0
    }

    // Method to count occurrences of a given key
    public int countOccurrences(int key) {
        int count = 0;
        Node curnode = head;
        for (int i = 1; i <= size; i++) {
            count += curnode.data == key ? 1 : 0;
            curnode = curnode.next;
        }
        return count;
    }

    // Method to add an element at a given position (1-based index)
    public int addAtPosition(int data, int position) {
        // position needs to be one of 1, .., size+1
        if (position > size + 1 || position < 1) return -1;

        // edge cases (head/tail shenanigans)
        if (position == 1) addFirst(data);
        else if (position == size+1) addLast(data);
        else { // other cases, position is in the middle of the list
            Node prevnode = head;
            // move to next node position-2 times --> reach index 1+position-2 = position-1
            for (int i = 1; i < position-1; i++) {
                prevnode = prevnode.next;
            }
            Node newnode = new Node(data);
            newnode.next = prevnode.next;
            prevnode.next = newnode;
            size++;
        }
        return 0;
    }

    // Method to remove the first element
    public boolean removeFirst() {
        if (head == null) return false;

        head = head.next;
        if (head == null) {
            tail = null;
        }
        size--;
        return true;
    }

    // Method to remove the last element
    public boolean removeLast() {
        if (head == null) return false;

        if (head == tail) {
            head = null;
            tail = null;
        } else {
            Node current = head;
            while (current.next != tail) {
                current = current.next;
            }
            current.next = null;
            tail = current;
        }
        size--;
        return true;
    }

    // Method to remove an element by key
    public int removeKey(int key) {
        int toReturn = removeAtPosition(search(key)); // handles shenanigans with head/tail
        // toReturn = 0 if removal succeeds (key found + removed), else -1
        return toReturn;
    }

    // Method to remove an element at a given position (1-based index)
    public int removeAtPosition(int position) {
        if (position > size || position < 1) return -1; // automatically handles size=0

        // edge cases (head/tail shenanigans)
        if (position == 1) removeFirst();
        else if (position == size) removeLast();
        else { // other cases, position is at middle of list
            Node prevnode = head;
            // move to next node position-2 times --> reach index 1+position-2 = position-1
            for (int i = 1; i < position-1; i++) {
                prevnode = prevnode.next;
            }
            prevnode.next = prevnode.next.next;
            size--;
        }
        return 0;
    }

    // Method to print the elements of the list
    public void print() {
        Node current = head;
        while (current != null) {
            System.out.print(current.data + " -> ");
            current = current.next;
        }
        System.out.println("null");
    }
}

class Main {
    public static void main(String[] args) {
        SinglyLinkedList list = new SinglyLinkedList();

        // Initial operations
        list.addLast(10);
        list.addLast(20);
        list.addLast(30);
        list.addLast(30);
        list.addLast(20);
        list.addLast(10);
        list.addLast(10);
        list.addLast(20);
        list.addLast(30);
        list.addFirst(40);
        list.addFirst(50);
        list.removeFirst(); // Removes 50
        list.removeFirst(); // Removes 40
        list.removeLast();  // Removes 30
        list.removeLast();  // Removes 20
        list.print();       // 10 -> 20 -> 30 -> 30 -> 20 -> 10 -> 10 -> null
        
        System.out.print("Keys at even positions: ");
        list.printEvenPositions(); // 20 30 10
        list.addFirst(20);         // Adds 20 at the start
        System.out.print("Keys at even positions: ");
        list.printEvenPositions(); // 10 30 20 10

        list.addAtPosition(60, 1); // Adds 60 at position 1 
        list.addAtPosition(20, 6); // Adds 20 at position 6
        list.addAtPosition(30, 7); // Adds 30 at position 7
        list.addAtPosition(50, 15); // Position 15 is invalid and hence 50 is not added
        list.print(); // 60 -> 20 -> 10 -> 20 -> 30 -> 20 -> 30 -> 30 -> 20 -> 10 -> 10 -> null

        int index = list.search(70); 
        System.out.println("First index of 70: " + index); // -1 (70 is not in the list)

        index = list.search(10); 
        System.out.println("First index of 10: " + index); // 3

        index = list.search(60); 
        System.out.println("First index of 60: " + index); // 1

        int count = list.countOccurrences(70);
        System.out.println("Occurrences of 70: " + count); // 0 (70 is not in the list)

        count = list.countOccurrences(30);
        System.out.println("Occurrences of 30: " + count); // 3

        count = list.countOccurrences(60);
        System.out.println("Occurrences of 60: " + count); // 1
        
        list.removeKey(30); // Removes the first occurrence of 30
        list.removeKey(30); // Removes the next occurrence of 30
        list.removeKey(30); // Removes the last occurrence of 30
        list.removeKey(30); // 30 does not appear and hence it cannot be removed
        list.print(); // 60 -> 20 -> 10 -> 20 -> 20 -> 20 -> 10 -> 10 -> null

        list.removeAtPosition(1); // Removes the first element (60)
        list.removeAtPosition(7); // Removes the last element (10)
        list.removeAtPosition(7); // Position invalid and hence does nothing
        list.print(); // 20 -> 10 -> 20 -> 20 -> 20 -> 10 -> null 
    }
}

/*
Expected Output:

10 -> 20 -> 30 -> 30 -> 20 -> 10 -> 10 -> null
Keys at even positions: 20 30 10 
Keys at even positions: 10 30 20 10 
60 -> 20 -> 10 -> 20 -> 30 -> 20 -> 30 -> 30 -> 20 -> 10 -> 10 -> null
First index of 70: -1
First index of 10: 3
First index of 60: 1
Occurrences of 70: 0
Occurrences of 30: 3
Occurrences of 60: 1
60 -> 20 -> 10 -> 20 -> 20 -> 20 -> 10 -> 10 -> null
20 -> 10 -> 20 -> 20 -> 20 -> 10 -> null
*/
