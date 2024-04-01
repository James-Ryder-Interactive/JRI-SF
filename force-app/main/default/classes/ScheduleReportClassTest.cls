@isTest
public class ScheduleReportClassTest {
 	@isTest
    static void testScheduleReportClass() {
        // Set up any necessary test data

        // Schedule the job
        Test.startTest();
        String jobId = System.schedule('TestScheduleJob', '0 0 * * * ?', new ScheduleReportClass());
        Test.stopTest();

        Integer waitTime = 5000;
        Long endTime = DateTime.now().getTime() + waitTime;
        while (DateTime.now().getTime() < endTime) {
            // Do nothing, just wait
        }
        
        System.abortJob(jobId);
    }
}