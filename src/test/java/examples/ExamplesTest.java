package examples;

import com.intuit.karate.junit5.Karate;

class ExamplesTest {
    
    // this will run all *.feature files that exist in sub-directories

    @Karate.Test
    Karate testAll() {
        return Karate.run("classpath:examples/users/userview.feature").tags("@view-user").relativeTo(getClass());
    }
    
}
