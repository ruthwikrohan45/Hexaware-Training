import java.util.Scanner;

public class LinearSearch {
    static int search(int[] a, int target) {
        for (int i = 0; i < a.length; i++) {
            if (a[i] == target) return i + 1;
        }
        return -1;
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter array size: ");
        int n = sc.nextInt();
        int[] a = new int[n];

        System.out.println("Enter array elements:");
        for (int i = 0; i < n; i++) a[i] = sc.nextInt();

        System.out.print("Enter target: ");
        int target = sc.nextInt();

        int position = search(a, target);
        if (position == -1) System.out.println("Element not found");
        else System.out.println("Element found at position: " + position);
        sc.close();
    }
}
