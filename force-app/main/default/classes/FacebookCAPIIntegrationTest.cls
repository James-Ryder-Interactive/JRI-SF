@isTest
public class FacebookCAPIIntegrationTest {
    @isTest
    static void testSendEvent() {
        // Set up test data and context if needed
        
        // Create a mock response
        HttpCalloutMock mock = new HttpIntegrationMock();
        
        // Start test, associate the mock with a callout
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, mock);
        
        // Call the method you want to test
        FacebookCAPIIntegration.sendEvent('accesToken','TestEvent', new Map<String, Object>());
        
        // Stop test
        Test.stopTest();
        
        // Perform assertions
        System.assertEquals(200, HttpIntegrationMock.getResponseToReturn().getStatusCode());
    }
}