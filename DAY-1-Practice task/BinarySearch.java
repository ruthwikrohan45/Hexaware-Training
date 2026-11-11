import java.util.Arrays;
import java.util.Scanner;

public class BinarySearch {
    static int search(int[] a, int target) {
        int low = 0, high = a.length - 1;

        while (low <= high) {
            int mid = low + (high - low) / 2;

            if (a[mid] == target) return mid + 1;
            if (a[mid] < target) low = mid + 1;
            else high = mid - 1;
        }
        return -1;
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter array size: ");
        int n = sc.nextInt();
        int[] a = new int[n];

        System.out.println("Enter elements in ascending order:");
        for (int i = 0; i < n; i++) a[i] = sc.nextInt();

        System.out.print("Enter target: ");
        int target = sc.nextInt();

        int position = search(a, target);
        if (position == -1) System.out.println("Element not found");
        else System.out.println("Element found at position: " + position);
        sc.close();
    }
}
