@IsTest
public class SmartAdvocateModelTest {

   @isTest
    static void testMapToSmartAdvocateFields() {
        // Create test data
        Lead testLead = new Lead(
            FirstName = 'John',
            LastName = 'Doe',
            Email = 'john.doe@example.com',
            Phone = '1234567890',
            City = 'Los Angeles',
            State = 'California',
            PostalCode = '12345'
        );
        
        Roundup__c testRoundup = new Roundup__c(
            Lead__c = testLead.Id,
            Caller_Date_of_Birth__c = Date.newInstance(1990, 1, 1),
            Injured_Party_Gender__c = 'Male'
            // ... other required fields ...
        );

        insert testLead;
        insert testRoundup;

        // Call the method under test
        List<Object> result = SmartAdvocateModel.mapToSmartAdvocateFields(new List<Roundup__c>{testRoundup});

        // Verify the results
        System.assertEquals(1, result.size(), 'Expected one record in the output list');

        Map<String, String> resultMap = (Map<String, String>) result[0];

        // Ensure that null fields are handled properly
        Roundup__c testRoundupWithoutLead = new Roundup__c(Caller_Date_of_Birth__c = Date.newInstance(1990, 1, 1));
        List<Object> resultWithoutLead = SmartAdvocateModel.mapToSmartAdvocateFields(new List<Roundup__c>{testRoundupWithoutLead});
    }
}