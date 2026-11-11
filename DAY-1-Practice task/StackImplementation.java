import java.util.Scanner;

class MyStack {
    int[] stack = new int[5];
    int top = -1;

    void push(int value) {
        if (top == stack.length - 1) System.out.println("Stack Overflow!");
        else {
            stack[++top] = value;
            System.out.println(value + " pushed");
        }
    }

    void pop() {
        if (top == -1) System.out.println("Stack Underflow!");
        else System.out.println("Popped: " + stack[top--]);
    }

    void show() {
        if (top == -1) System.out.println("Stack is Empty");
        else {
            System.out.println("Stack Elements:");
            for (int i = top; i >= 0; i--) System.out.println(stack[i]);
        }
    }

    void peek() {
        if (top == -1) System.out.println("Stack is Empty");
        else System.out.println("Top Element: " + stack[top]);
    }
}

public class StackImplementation {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        MyStack s = new MyStack();
        int choice;

        do {
            System.out.println("\\n===== STACK MENU =====");
            System.out.println("1. PUSH\\n2. POP\\n3. SHOW\\n4. PEEK\\n5. EXIT");
            System.out.print("Enter choice: ");
            choice = sc.nextInt();

            switch (choice) {
                case 1:
                    System.out.print("Enter value: ");
                    s.push(sc.nextInt());
                    break;
                case 2: s.pop(); break;
                case 3: s.show(); break;
                case 4: s.peek(); break;
                case 5: System.out.println("Thank You!"); break;
                default: System.out.println("Invalid Choice!");
            }
        } while (choice != 5);
        sc.close();
    }
}
