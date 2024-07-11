@isTest
public class SendSignatureRequestWithTemplateTest {
    @isTest
    static void testGenerateHelloSignature() {
        // Create a test HelloSign__Template__c record
        HelloSign__Template__c testTemplate = new HelloSign__Template__c(
            Name = 'Saddle Rock- Talcum Powder- Please sign',
            HelloSign__Status__c = 'Sent'
        );
        insert testTemplate;

        // Create a test HelloSign__SignerRole__c record associated with the template
        HelloSign__SignerRole__c testRole = new HelloSign__SignerRole__c(
            HelloSign__Template__c = testTemplate.Id,
            HelloSign__SpecificEmail__c = 'test@example.com',
            HelloSign__SpecificFirstName__c = 'Test'
        );
        insert testRole;

        Campaign relatedCampaign = new Campaign();
        relatedCampaign.Name = 'Talc';
        insert relatedCampaign;
        
        Account relatedCompany = new Account();
        relatedCompany.Name = 'Saddle Rock';
        insert relatedCompany;
        
        Lead leadObject = new Lead();
        leadObject.LastName = 'test';
        leadObject.Campaign__c = relatedCampaign.Id;
        leadObject.Company__c = relatedCompany.Id;
        insert leadObject;
        
        Talc__c talcObject = new Talc__c();
        talcObject.Lead__c = leadObject.Id;
        insert talcObject;

        Test.startTest();
        // Call the method with the test data
        sendSignatureReequestWithTemplate.generateHelloSignature('test@example.com', 'Test', talcObject.Id);
        Test.stopTest();
    }
}