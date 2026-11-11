import java.util.Scanner;

class LLNode {
    int data;
    LLNode next;

    LLNode(int value) {
        data = value;
        next = null;
    }
}

class MyLinkedList {
    LLNode head = null;

    void insertAtBeginning(int value) {
        LLNode newNode = new LLNode(value);
        newNode.next = head;
        head = newNode;
        System.out.println(value + " inserted at beginning.");
    }

    void insertAtEnd(int value) {
        LLNode newNode = new LLNode(value);
        if (head == null) {
            head = newNode;
        } else {
            LLNode temp = head;
            while (temp.next != null) temp = temp.next;
            temp.next = newNode;
        }
        System.out.println(value + " inserted at end.");
    }

    void insertAtPosition(int value, int position) {
        if (position < 1) {
            System.out.println("Invalid position.");
            return;
        }
        if (position == 1) {
            insertAtBeginning(value);
            return;
        }

        LLNode temp = head;
        for (int i = 1; i < position - 1 && temp != null; i++) temp = temp.next;
        if (temp == null) {
            System.out.println("Position is out of range.");
            return;
        }

        LLNode newNode = new LLNode(value);
        newNode.next = temp.next;
        temp.next = newNode;
        System.out.println(value + " inserted at position " + position + ".");
    }

    void deleteFromBeginning() {
        if (head == null) {
            System.out.println("List is empty.");
            return;
        }
        System.out.println("Deleted: " + head.data);
        head = head.next;
    }

    void deleteFromEnd() {
        if (head == null) {
            System.out.println("List is empty.");
            return;
        }
        if (head.next == null) {
            System.out.println("Deleted: " + head.data);
            head = null;
            return;
        }

        LLNode temp = head;
        while (temp.next.next != null) temp = temp.next;
        System.out.println("Deleted: " + temp.next.data);
        temp.next = null;
    }

    void deleteAtPosition(int position) {
        if (head == null) {
            System.out.println("List is empty.");
            return;
        }
        if (position < 1) {
            System.out.println("Invalid position.");
            return;
        }
        if (position == 1) {
            deleteFromBeginning();
            return;
        }

        LLNode temp = head;
        for (int i = 1; i < position - 1 && temp != null; i++) temp = temp.next;
        if (temp == null || temp.next == null) {
            System.out.println("Position is out of range.");
            return;
        }

        System.out.println("Deleted: " + temp.next.data);
        temp.next = temp.next.next;
    }

    void display() {
        if (head == null) {
            System.out.println("List is empty.");
            return;
        }
        LLNode temp = head;
        System.out.print("Linked List: ");
        while (temp != null) {
            System.out.print(temp.data + " -> ");
            temp = temp.next;
        }
        System.out.println("null");
    }

    void search(int value) {
        LLNode temp = head;
        int position = 1;
        while (temp != null) {
            if (temp.data == value) {
                System.out.println(value + " found at position " + position + ".");
                return;
            }
            temp = temp.next;
            position++;
        }
        System.out.println(value + " not found.");
    }
}

public class LinkedListDemo {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        MyLinkedList list = new MyLinkedList();
        int choice;

        do {
            System.out.println("\n===== LINKED LIST MENU =====");
            System.out.println("1. Insert at beginning");
            System.out.println("2. Insert at end");
            System.out.println("3. Insert at position");
            System.out.println("4. Delete from beginning");
            System.out.println("5. Delete from end");
            System.out.println("6. Delete at position");
            System.out.println("7. Display");
            System.out.println("8. Search");
            System.out.println("9. Exit");
            System.out.print("Enter choice: ");
            choice = sc.nextInt();

            int value, position;
            switch (choice) {
                case 1:
                    System.out.print("Enter value: ");
                    list.insertAtBeginning(sc.nextInt());
                    break;
                case 2:
                    System.out.print("Enter value: ");
                    list.insertAtEnd(sc.nextInt());
                    break;
                case 3:
                    System.out.print("Enter value: ");
                    value = sc.nextInt();
                    System.out.print("Enter position: ");
                    position = sc.nextInt();
                    list.insertAtPosition(value, position);
                    break;
                case 4: list.deleteFromBeginning(); break;
                case 5: list.deleteFromEnd(); break;
                case 6:
                    System.out.print("Enter position: ");
                    list.deleteAtPosition(sc.nextInt());
                    break;
                case 7: list.display(); break;
                case 8:
                    System.out.print("Enter value to search: ");
                    list.search(sc.nextInt());
                    break;
                case 9: System.out.println("Thank you!"); break;
                default: System.out.println("Invalid choice.");
            }
        } while (choice != 9);
        sc.close();
    }
}
