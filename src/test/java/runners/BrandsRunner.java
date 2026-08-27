package runners;

import com.intuit.karate.junit5.Karate;

public class BrandsRunner {

    @Karate.Test
    Karate brands() {
        return Karate.run("classpath:brands");
    }
}