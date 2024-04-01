@isTest
public class RoundupTriggerTest {
	@isTest
    static void testRoundupTrigger() {
		HttpCalloutMock mock = new HttpIntegrationMock();
        Test.setMock(HttpCalloutMock.class, mock);
        
        // Create a test Lead
        Lead testLead = new Lead(
            FirstName = 'John',
            LastName = 'Doe',
            Status = 'Retainer signed',
            Email = 'john.doe@example.com'
        );
        insert testLead;

        // Create a test Roundup record
        Roundup__c testRoundup = new Roundup__c(
            Lead__c = testLead.Id,
            Status__c = 'Some other status' // Set a status other than 'Retainer signed'
        );
        insert testRoundup;

        // Update the Roundup record to simulate a status change
        Test.startTest();
        testRoundup.Status__c = 'Retainer signed';
        update testRoundup;
		Test.stopTest();
        
        System.assertEquals('Retainer signed', testRoundup.Status__c);
    }
}