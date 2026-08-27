package runners;

import com.intuit.karate.junit5.Karate;

public class ProductsRunner {

    @Karate.Test
    Karate products() {
        return Karate.run("classpath:products");
    }
}