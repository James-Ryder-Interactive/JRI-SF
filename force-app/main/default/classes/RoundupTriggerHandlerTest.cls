@IsTest
public class RoundupTriggerHandlerTest {
	@IsTest
    static void testSendDataToSmartAdvocate() {
        HttpCalloutMock mock = new HttpIntegrationMock();
        Test.setMock(HttpCalloutMock.class, mock);
        
        // Create a test Lead
        Lead testLead = new Lead(
            FirstName = 'Test',
            LastName = 'Lead',
            Email = 'test@example.com',
            Phone = '555-555-5555'
            // Add other required fields
        );
        insert testLead;

        // Create a test Roundup record related to the test Lead
        Roundup__c testRoundup = new Roundup__c(
            Lead__c = testLead.Id,
            Name = 'Test Name'
            // Set other required fields for your Roundup__c object
        );
        insert testRoundup;

        Test.startTest();
        RoundupTriggerHandler.sendDataToSmartAdvocate(testRoundup.Id);
        Test.stopTest();
    }
}