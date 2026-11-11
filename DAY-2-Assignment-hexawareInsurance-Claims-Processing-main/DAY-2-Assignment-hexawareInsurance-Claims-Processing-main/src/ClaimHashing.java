import java.util.*;
public class ClaimHashing {
    public static void main(String[] args) {
        HashMap<String, String> claims = new HashMap<>();
        String[] policyNumbers = {
                "POL123",
                "POL456",
                "pol123",
                "POL789",
                " POL456 "
        };
        String[] dates = {
                "2026-11-01",
                "2026-11-02",
                "2026-11-01",
                "2026-11-03",
                "2026-11-02"
        };
        for (int i = 0; i < policyNumbers.length; i++) {
            String policy = policyNumbers[i].replace(" ", "").toUpperCase();
            String key = policy + dates[i];
            if (claims.containsKey(key)) {
                System.out.println("Duplicate Claim: " + policy);
            } else {
                claims.put(key, policy);
                System.out.println("New Claim: " + policy);
            }
        }
        System.out.println("Total Unique Claims: " + claims.size());
    }
}
