import java.util.LinkedList;
import java.util.Queue;
import java.util.Scanner;

public class QueueRotation {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        Queue<Integer> q = new LinkedList<>();

        System.out.print("Enter number of elements: ");
        int n = sc.nextInt();

        System.out.println("Enter queue elements:");
        for (int i = 0; i < n; i++) q.offer(sc.nextInt());

        if (!q.isEmpty()) {
            int temp = q.poll();
            q.offer(temp);
        }

        System.out.println("Queue after moving first element to last: " + q);
        sc.close();
    }
}
