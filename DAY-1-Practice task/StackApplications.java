import java.util.Scanner;
import java.util.Stack;

public class StackApplications {
    static void reverseArray(int[] a) {
        Stack<Integer> stack = new Stack<>();
        for (int value : a) stack.push(value);

        for (int i = 0; i < a.length; i++) a[i] = stack.pop();
    }

    static String reverseEachWord(String input) {
        Stack<Character> stack = new Stack<>();
        StringBuilder result = new StringBuilder();

        for (int i = 0; i < input.length(); i++) {
            char ch = input.charAt(i);

            if (ch != ' ') stack.push(ch);
            else {
                while (!stack.isEmpty()) result.append(stack.pop());
                result.append(' ');
            }
        }

        while (!stack.isEmpty()) result.append(stack.pop());
        return result.toString();
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Enter array size: ");
        int n = sc.nextInt();
        int[] a = new int[n];
        System.out.println("Enter array elements:");
        for (int i = 0; i < n; i++) a[i] = sc.nextInt();

        reverseArray(a);
        System.out.print("Reversed array: ");
        for (int value : a) System.out.print(value + " ");

        sc.nextLine();
        System.out.print("\\nEnter a sentence: ");
        String sentence = sc.nextLine();
        System.out.println("Each word reversed: " + reverseEachWord(sentence));
        sc.close();
    }
}
