@isTest
public class UpdateLeadSignedDateAndStatusTest {
	@isTest
    static void testTrigger_dateSignedUpdated_Lead() {
        
	//EvergreenIntegrationTest.testSendEvent();
        
        // Create a Lead
        Lead testLead = new Lead(
            FirstName = 'ASDG',
            LastName = 'ASDGF',
            Company = 'Test Company ASDGF'
        );
        insert testLead;
        
        // Create a HelloSign__HelloSign_Signature_Request__c record related to the Lead
        HelloSign__HelloSign_Signature_Request__c testRequest = new HelloSign__HelloSign_Signature_Request__c(
            HelloSign__Lead__c = testLead.Id
        );
        insert testRequest;
        
        // Create a HelloSign__HelloSign_Signature_Request_Detail__c record related to the request
        HelloSign__HelloSign_Signature_Request_Detail__c testDetail = new HelloSign__HelloSign_Signature_Request_Detail__c(
            HelloSign__HelloSign_Signature_Request__c = testRequest.Id,
            HelloSign__Date__c = Date.today(),
            HelloSign__Event__c = 'Signed'
        );
        insert testDetail;
        
        // Trigger should update the Lead's Signed_Date__c field
        List<Lead> updatedLeads = [SELECT Id, Date_Signed__c FROM Lead WHERE Id = :testLead.Id];
        System.assertEquals(Date.today(), updatedLeads[0].Date_Signed__c);
    }
    
    @isTest
    static void testTrigger_dateSentUpdated_Lead() {
        
	//EvergreenIntegrationTest.testSendEvent();
        
        // Create a Lead
        Lead testLead = new Lead(
            FirstName = 'ASDG',
            LastName = 'ASDGF',
            Company = 'Test Company ASDGF'
        );
        insert testLead;
        
        // Create a HelloSign__HelloSign_Signature_Request__c record related to the Lead
        HelloSign__HelloSign_Signature_Request__c testRequest = new HelloSign__HelloSign_Signature_Request__c(
            HelloSign__Lead__c = testLead.Id
        );
        insert testRequest;
        
        // Create a HelloSign__HelloSign_Signature_Request_Detail__c record related to the request
        HelloSign__HelloSign_Signature_Request_Detail__c testDetail = new HelloSign__HelloSign_Signature_Request_Detail__c(
            HelloSign__HelloSign_Signature_Request__c = testRequest.Id,
            HelloSign__Date__c = Date.today(),
            HelloSign__Event__c = 'Sent'
        );
        insert testDetail;
        
        // Trigger should update the Lead's Signed_Date__c field
        List<Lead> updatedLeads = [SELECT Id, Date_Retainer_Sent__c FROM Lead WHERE Id = :testLead.Id];
        System.assertEquals(Date.today(), updatedLeads[0].Date_Retainer_Sent__c);
    }
    
    @isTest
    static void testTrigger_dateSentUpdated_Talc() {   
	//EvergreenIntegrationTest.testSendEvent();
        
        // Create a Lead
        Lead testLead = new Lead(
            FirstName = 'ASDG',
            LastName = 'ASDGF',
            Company = 'Test Company ASDGF'
        );
        insert testLead;
        
        // Create a Talc	
        Talc__c testTalc = new Talc__c(
            Name = 'ASDG',
            Lead__c = testLead.Id
        );

 		insert testTalc;
        
        // Create a HelloSign__HelloSign_Signature_Request__c record related to the Talc
        HelloSign__HelloSign_Signature_Request__c testTalcRequest = new HelloSign__HelloSign_Signature_Request__c(
            Talc__c = testTalc.Id
        );
        insert testTalcRequest;
        
        HelloSign__HelloSign_Signature_Request_Detail__c testTalcDetail = new HelloSign__HelloSign_Signature_Request_Detail__c(
            HelloSign__HelloSign_Signature_Request__c = testTalcRequest.Id,
            HelloSign__Date__c = Date.today(),
            HelloSign__Event__c = 'Sent'
        );
        insert testTalcDetail;
        
        // Trigger should update the Lead's Date_Retainer_Sent__c field
        List<Lead> updatedLeads = [SELECT Id, Date_Signed__c, Date_Retainer_Sent__c FROM Lead WHERE Id = :testTalc.Lead__c];
        System.assertEquals(Date.today(), updatedLeads[0].Date_Retainer_Sent__c);
    }
}