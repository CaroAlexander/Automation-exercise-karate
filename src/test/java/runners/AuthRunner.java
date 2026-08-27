package runners;

import com.intuit.karate.junit5.Karate;

public class AuthRunner {

    @Karate.Test
    Karate auth() {
        return Karate.run("classpath:auth");
    }
}