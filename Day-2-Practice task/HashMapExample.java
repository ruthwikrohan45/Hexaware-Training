import java.util.HashMap;
import java.util.Map;

public class HashMapExample {
    public static void main(String[] args) {
        HashMap<String, Integer> mobilePrices = new HashMap<>();

        mobilePrices.put("iPhone", 85000);
        mobilePrices.put("Samsung", 65000);
        mobilePrices.put("OnePlus", 45000);
        mobilePrices.put("Pixel", 70000);
        mobilePrices.put("Nothing", 35000);

        System.out.println("Mobile Phone Prices:");
        for (Map.Entry<String, Integer> entry : mobilePrices.entrySet()) {
            System.out.println(entry.getKey() + " - Rs. " + entry.getValue());
        }

        System.out.println("\nPrice of Samsung: Rs. " + mobilePrices.get("Samsung"));
        mobilePrices.put("OnePlus", 48000);
        System.out.println("Updated OnePlus price: Rs. " + mobilePrices.get("OnePlus"));

        mobilePrices.remove("Nothing");
        System.out.println("\nAfter removing Nothing: " + mobilePrices);
    }
}
