package runner;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

class TestRunner {

    @Test
    void run() {
        System.out.println("Test Runner Starting...");
        Results results = Runner.path("classpath:features")
                .tags("@e2e")
                .outputCucumberJson(true)
                .parallel(1);

        Assertions.assertEquals(0, results.getFailCount(), "All tests passed");
    }
}
