@isTest
public class SmartAdvocateScheduleTest {
    @isTest
    static void testExecuteMethod() {
        // Create a mock response
        HttpCalloutMock mock = new HttpIntegrationMock();
        Test.setMock(HttpCalloutMock.class, mock);
        
        Lead testLead = TestDataFactory.createTestLead();

        String smartAdvocateModelJson = JSON.serialize(testLead);
        String leadId = testLead.Id;
        String leadDataEndpoint = 'https://example.com/api/lead-data';
        String apiKey = '1234';
        String documentUploadEndpoint = 'https://documentUpload.example.com';

        // Create an instance of ScheduleRoundupIntegration
        SmartAdvocateSchedule scheduledJob = new SmartAdvocateSchedule (
            smartAdvocateModelJson, 
            leadId, 
            leadDataEndpoint, 
            apiKey, 
            documentUploadEndpoint);

        // Call the execute method
        Test.startTest();
        scheduledJob.execute(null); // SchedulableContext is not used in this example
        Test.stopTest();

        // Example assertion:
        // System.assertEquals(expectedValue, actualValue, 'Assertion Message');
    }
}