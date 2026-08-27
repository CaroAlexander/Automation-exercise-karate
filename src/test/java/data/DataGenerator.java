package data;

public class DataGenerator {

    public static String generateEmail() {
        return "qa.automation."
                + System.currentTimeMillis()
                + "@test.com";
    }
}