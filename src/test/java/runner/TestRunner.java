package runner;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

class TestRunner {

    @Test
    void run() {
        System.out.println("Test Runner Starting...");
        Results results = Runner.path("classpath:features")
                .tags("@n8n")
                .outputCucumberJson(true)
                .parallel(1);
        System.out.println("Running cleanup after all organization flow tests...");
        Runner.path("classpath:features/orchestrator/Cleanup.feature").tags("@cleanupOrganizationFlow").parallel(1);

        assert results.getFailCount() == 0 : "There are failed scenarios. Check the report for details.";
    }

}
