@isTest
public class MapToEvergreenTest {
 	@isTest
    static void testMapLeadToEvergreen() {
        
        // Create test data using TestDataFactory
        Test.startTest();
        Lead testLead = TestDataFactory.createTestLead();
		
        // Create an instance of MapToEvergreen and call mapToEvergreenFields
        List<Object> result = MapToEvergreen.mapToEvergreenFields(testLead);
		Test.stopTest();
        // Assert that the result is not null and has the correct size
        System.assertNotEquals(null, result);
        System.assertEquals(1, result.size());

    }
    
    @isTest
    static void testMapTalcToEvergreen() {
		EvergreenIntegrationTest.testSendEvent();
        
        // Create test data using TestDataFactory
        Lead testLead = TestDataFactory.createTestLead();
        Talc__c testTalc = TestDataFactory.createTestTalc(testLead);

        // Create an instance of MapToEvergreen and call mapToEvergreenFields
        List<Object> result = MapToEvergreen.mapToEvergreenFields(testTalc);

        // Assert that the result is not null and has the correct size
        System.assertNotEquals(null, result);
        System.assertEquals(1, result.size());
    }
    
    @isTest
    static void testMapCMPLToEvergreen() {
		EvergreenIntegrationTest.testSendEvent();
        
        // Create test data using TestDataFactory
        Lead testLead = TestDataFactory.createTestLead();
        Camp_Lejeune__c testCMPL = TestDataFactory.createTestCMPL(testLead);

        // Create an instance of MapToEvergreen and call mapToEvergreenFields
        List<Object> result = MapToEvergreen.mapToEvergreenFields(testCMPL);

        // Assert that the result is not null and has the correct size
        System.assertNotEquals(null, result);
        System.assertEquals(1, result.size());
    }
    
    @isTest
    static void testMapTylenolToEvergreen() {
		EvergreenIntegrationTest.testSendEvent();
        
        // Create test data using TestDataFactory
        Lead testLead = TestDataFactory.createTestLead();
        Tylenol__c testTyl = TestDataFactory.createTestTylenol(testLead);

        // Create an instance of MapToEvergreen and call mapToEvergreenFields
        List<Object> result = MapToEvergreen.mapToEvergreenFields(testTyl);

        // Assert that the result is not null and has the correct size
        System.assertNotEquals(null, result);
        System.assertEquals(1, result.size());
    }
    
    @isTest
    static void testMapAttachmentToEvergreenFields() {
        EvergreenIntegrationTest.testSendEvent();
        
        // Create test data using TestDataFactory
        Lead testLead = TestDataFactory.createTestLead();
        ContentDocumentLink testAttachmentLink = TestDataFactory.createTestContentDocument(testLead);
    
        // Create an instance of MapToEvergreen and call mapAttachmentToEvergreenFields
        List<ContentDocumentLink> attachments = new List<ContentDocumentLink>{ testAttachmentLink };
            System.debug('attachments ::: ' + attachments);
        List<EvergreenDocumentModel> result = MapToEvergreen.mapAttachmentToEvergreenFields(attachments);
    
        // Assert that the result is not null and has the correct size
        System.assertNotEquals(null, result);
        System.assertEquals(1, result.size());
    
        // Assert details of the EvergreenDocumentModel
        EvergreenDocumentModel output = result[0];
        System.assertNotEquals(null, output.attachments);
        System.assertEquals(1, output.attachments.size());
        System.assertEquals(testAttachmentLink.LinkedEntityId, output.potentiallead.PotentialLeadID);
    }
}