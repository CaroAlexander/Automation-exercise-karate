package runners;

import com.intuit.karate.junit5.Karate;

public class UsersRunner {

    @Karate.Test
    Karate users(){
        return Karate.run("classpath:users");
    }
}
