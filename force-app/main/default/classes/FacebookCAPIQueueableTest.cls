@isTest
public class FacebookCAPIQueueableTest {
    @isTest
    static void testSendEventToFacebook() {
        // Set up test data if needed
        
        // Create a mock response
        HttpCalloutMock mock = new FacebookCAPIIntegrationMock();
        
        // Start test, associate the mock with a callout
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, mock);
        
        // Enqueue the queueable job
        System.enqueueJob(new FacebookCAPIQueueable('LeadId123'));
        
        // Stop test
        Test.stopTest();
        
        // Perform assertions if needed
    }
}