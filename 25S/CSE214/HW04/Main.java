class MinHeap {
    private int[] heap;
    private int size;
    private int capacity;
    
    public MinHeap(int capacity) {
        this.capacity = capacity;
        this.size = 0;
        this.heap = new int[capacity + 1]; // 1-based index heap
    }

    // Get parent index
    private int parent(int i) {
        return i / 2;
    }

    // Get left child index
    private int leftChild(int i) {
        return 2 * i;
    }

    // Get right child index
    private int rightChild(int i) {
        return 2 * i + 1;
    }

    // Add an element to the min-heap
    public void add(int value) {
        if (size+1 > capacity) System.out.println("failed to add " + value + " due to overflow.");
        else {
            heap[size+1] = value;
            size++;
            this.upHeap(size);
        }
    }

    // Upheap (bubble up) to maintain min-heap order
    private void upHeap(int i) {
        if (i > 1 && heap[this.parent(i)] > heap[i]) {
            this.swap(i, this.parent(i));
            this.upHeap(this.parent(i));
        }
    }

    // Remove the minimum element (root of the heap)
    public int removeMin() {
        int removed = heap[1];
        this.swap(1,size);
        size--;
        this.downHeap(1);
        return removed;
    }

    // Downheap (bubble down) to maintain min-heap property
    private void downHeap(int i) {
        int rc = this.rightChild(i);
        int lc = this.leftChild(i);
        // check for number of children
        if (lc > size) return;
        else if (rc > size) {
            if (heap[lc] < heap[i]){
                this.swap(i, lc);
                this.downHeap(lc);
            }
        }
        else {
            if (heap[rc] < heap[lc]) {
                if (heap[i] > heap[rc]) this.swap(i,rc);
                downHeap(rc);
            }
            else {
                if (heap[i] > heap[lc]) this.swap(i,lc);
                downHeap(lc);
            }
        }
    }

    // Swap helper function
    private void swap(int i, int j) {
        int temp = heap[i];
        heap[i] = heap[j];
        heap[j] = temp;
    }

    // Print heap contents
    public void print() {
        System.out.print("MinHeap: ");
        for (int i = 1; i <= size; i++) {
            System.out.print(heap[i] + " ");
        }
        System.out.println();
    }
}

// Separate Main class to run the program
public class Main {
    public static void main(String[] args) {
        MinHeap minHeap = new MinHeap(15); // Increased capacity for more tests

        // Complex test case with 10 unsorted numbers
        int[] numbers = {50, 20, 15, 30, 10, 40, 5, 60, 25, 35};

        for (int num : numbers) {
            System.out.println("Add: " + num);
            minHeap.add(num);
            minHeap.print();
        }

        // Remove minimum elements multiple times
        for (int i = 0; i < 5; i++) {  // Removing 5 times
            System.out.println("Removed min: " + minHeap.removeMin());
            minHeap.print();
        }
    }
}
