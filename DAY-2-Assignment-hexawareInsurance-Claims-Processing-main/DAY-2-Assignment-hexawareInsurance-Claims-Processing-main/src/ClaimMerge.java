
public class ClaimMerge {
    public static void main(String[] args) {
        int[] office1 = {101, 103, 105, 107, 109};
        int[] office2 = {102, 104, 106, 108, 110};
        int i = 0, j = 0, k = 0;
        int[] result = new int[office1.length + office2.length];
        while (i < office1.length && j < office2.length) {
            if (office1[i] < office2[j]) {
                result[k] = office1[i];
                i++;
            } else {
                result[k] = office2[j];
                j++;
            }
            k++;
        }
        while (i < office1.length) {
            result[k] = office1[i];
            i++;
            k++;
        }
        while (j < office2.length) {
            result[k] = office2[j];
            j++;
            k++;
        }
        System.out.println("Merged Claim List:");
        for (int value : result) {
            System.out.print(value + " ");
        }
    }
}
