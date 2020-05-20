package examples;

//import static org.junit.jupiter.api.Assertions.assertEquals;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.commons.io.FileUtils;

import com.intuit.karate.Results;
//import static org.junit.Assert.*;
import com.intuit.karate.Runner;
//import com.intuit.karate.junit5.Karate.Test;

import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;


class TestParallel {



    @Test
    void testParallel() {
        // System.setProperty("karate.env", "demo"); // ensure reset if other tests (e.g. mock) had set env in CI
        Results results = Runner.path("classpath:examples/users").tags("@positive").parallel(15);
        generateReport(results.getReportDir());

        assertEquals(0, results.getFailCount(), results.getErrorMessages());

    }


    public static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
        List<String> jsonPaths = new ArrayList(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "demo");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }

}
