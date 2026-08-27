package runners;

import com.intuit.karate.junit5.Karate;

public class SearchProductsRunner {

    @Karate.Test
    Karate searchProducts() {
        return Karate.run("classpath:searchproducts");
    }
}