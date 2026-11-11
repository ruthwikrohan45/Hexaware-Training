
public class ClaimSlidingWindow {

    public static void main(String[] args) {
        int[] claims = {
                120, 150, 130, 90, 110,
                140, 160, 170, 80, 120,
                130, 150, 90, 110
        };
        int count = 0;
        int max = 0;
        for (int i = 0; i < claims.length; i++) {
            if (claims[i] > 100) {
                count++;
            } else {
                count = 0;
            }
            if (count > max) {
                max = count;
            }
        }
        System.out.println("Longest consecutive days: " + max);
    }
}
