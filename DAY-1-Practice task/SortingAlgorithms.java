import java.util.Scanner;
import java.util.Arrays;

public class SortingAlgorithms {
    static void bubbleSort(int[] a) {
        for (int i = 0; i < a.length - 1; i++) {
            for (int j = 0; j < a.length - 1 - i; j++) {
                if (a[j] > a[j + 1]) {
                    int temp = a[j];
                    a[j] = a[j + 1];
                    a[j + 1] = temp;
                }
            }
        }
    }

    static void selectionSort(int[] a) {
        for (int i = 0; i < a.length - 1; i++) {
            int minIndex = i;
            for (int j = i + 1; j < a.length; j++) {
                if (a[j] < a[minIndex]) minIndex = j;
            }
            int temp = a[i];
            a[i] = a[minIndex];
            a[minIndex] = temp;
        }
    }

    static void insertionSort(int[] a) {
        for (int i = 1; i < a.length; i++) {
            int key = a[i];
            int j = i - 1;

            while (j >= 0 && a[j] > key) {
                a[j + 1] = a[j];
                j--;
            }
            a[j + 1] = key;
        }
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter array size: ");
        int n = sc.nextInt();
        int[] original = new int[n];

        System.out.println("Enter array elements:");
        for (int i = 0; i < n; i++) original[i] = sc.nextInt();

        int[] bubble = Arrays.copyOf(original, n);
        int[] selection = Arrays.copyOf(original, n);
        int[] insertion = Arrays.copyOf(original, n);

        bubbleSort(bubble);
        selectionSort(selection);
        insertionSort(insertion);

        System.out.println("Bubble Sort: " + Arrays.toString(bubble));
        System.out.println("Selection Sort: " + Arrays.toString(selection));
        System.out.println("Insertion Sort: " + Arrays.toString(insertion));
        sc.close();
    }
}
