@isTest
public class SmartAdvocateIntegrationTest {
	@isTest
    static void testSendLeadData() {       
        // Create a mock response
        HttpCalloutMock mock = new HttpIntegrationMock();
        Test.setMock(HttpCalloutMock.class, mock);
        
        Lead mockLead = new Lead(
            FirstName = 'John',
            LastName = 'Doe',
            Email = 'john.doe@example.com',
            Phone = '123-456-7890'
        );
        String leadDataJson = JSON.serialize(mockLead);

        Test.startTest();        
       	String result = SmartAdvocateIntegration.sendLeadData('https://sa.krauseandkinsman.com/saservice/sawebservice.svc/Receiver/OfficeCalls/test', leadDataJson);
        Test.stopTest();
        
        // Perform assertions
        System.assertEquals(200, HttpIntegrationMock.getResponseToReturn().getStatusCode());
        System.assertNotEquals('Error', result);
    }

    @isTest
    static void testSendDocument() {
        // Set the mock class for the callout
        HttpCalloutMock mock = new HttpIntegrationMock();
        Test.setMock(HttpCalloutMock.class, mock);

        Blob documentData = Blob.valueOf('Sample PDF content');
        String caseID = '1234';
        String subCategory = 'Authorization Medical';
        String filename = '1234_Plaintiff_Authorization_Medical.pdf';

        Test.startTest();
        SmartAdvocateIntegration.sendDocument (
            'https://na1.hostedmetrics.com/advocateme/v2/sendsignal/',
            'APIKey',
            documentData,
            filename
        );        
        Test.stopTest();

        System.assertEquals(200, HttpIntegrationMock.getResponseToReturn().getStatusCode());
    }
    
    @isTest
    static void testProcessDocumentsRoundup() {
        HttpCalloutMock mock = new HttpIntegrationMock();
        Test.setMock(HttpCalloutMock.class, mock);

        Lead testLead = new Lead(
            FirstName = 'Test',
            LastName = 'Lead'
        );
        insert testLead;
        
        Roundup__c testRoundup = new Roundup__c(
            Name = 'test'
        );
		insert testRoundup;

        ContentVersion testContentVersion = new ContentVersion(
            Title = 'Roundup CFA Document',
            VersionData = Blob.valueOf('Test PDF Content'),
            PathOnClient = 'TestDocument.pdf'
        );
        insert testContentVersion;
           
        Test.startTest();
        SmartAdvocateIntegration.processDocuments(testRoundup.Id, testLead.Id, 'apiKey', 'https://na1.hostedmetrics.com/advocateme/v2/docupload/');
        Test.stopTest();
    }
    
    @isTest
    static void testSendLeadDataAsync() {
        // Set the mock class for the callout
        HttpCalloutMock mock = new HttpIntegrationMock();
        Test.setMock(HttpCalloutMock.class, mock);

        // Now you can test the method as usual
        Lead testLead = new Lead(
            FirstName = 'John',
            LastName = 'Doe',
            Email = 'john.doe@example.com',
            Phone = '123-456-7890'
        );
        insert testLead;
        
        String leadDataJson = JSON.serialize(testLead);

        Roundup__c testRoundup = new Roundup__c(
            Lead__c = testLead.Id,
            Name = 'test name'
            // Set other required fields for your Roundup__c object
        );
        insert testRoundup;
        
        Test.startTest();
        try {
            SmartAdvocateIntegration.sendLeadDataAsync(
                leadDataJson,
                'LeadID',
                'https://example.com/test',
                'API_KEY',
                'https://example.com/upload'
            );
        } catch (Exception e) {
            System.debug('Exception caught: ' + e.getMessage());
        }        Test.stopTest();
        
		System.assertEquals(200, HttpIntegrationMock.getResponseToReturn().getStatusCode());    
    }

    @isTest
    static void testProcessDocuments() {
        HttpCalloutMock mock = new HttpIntegrationMock();
        Test.setMock(HttpCalloutMock.class, mock);

        // Create test Lead
        Lead testLead = new Lead(
            FirstName = 'Test',
            LastName = 'Lead'
        );
        insert testLead;
   
    
        // Create a ContentVersion for the ContentDocument
        ContentVersion testContentVersion = new ContentVersion(
            Title = 'Retainer Agreement Document', // Adjust title for specific logic branch
            VersionData = Blob.valueOf('Test PDF Content'),
            PathOnClient = 'Retainer.pdf',
            FirstPublishLocationId = testLead.Id
        );
        insert testContentVersion;


        // Create ContentVersion for default case
        ContentVersion defaultContentVersion = new ContentVersion(
            Title = 'Other Document',
            VersionData = Blob.valueOf('Test PDF Content for Other'),
            FirstPublishLocationId = testLead.Id,
            PathOnClient = 'OtherDocument.pdf'
        );
        insert defaultContentVersion;

            // Query the ContentDocumentId from the inserted ContentVersion
        ContentVersion contentVersion = [
            SELECT Id, ContentDocumentId, Title
            FROM ContentVersion
            WHERE Id = :testContentVersion.Id
        ];
        System.assertNotEquals(null, contentVersion.ContentDocumentId, 'ContentDocumentId should not be null.');
    
        // Define input parameters
        String caseID = '1234';
        String apiKey = 'testApiKey';
        String documentUploadEndpoint = 'https://example.com/docupload';
    
        // Test the processDocuments method
        Test.startTest();
        SmartAdvocateIntegration.processDocuments(caseID, testLead.Id, apiKey, documentUploadEndpoint);
        Test.stopTest();

        // Assert that the callout was made and processed correctly
        //System.assertEquals(200, HttpIntegrationMock.getResponseToReturn().getStatusCode());
    }

    @isTest
    public static void testProcessAttachments() {
        // Set up test data
        Lead testLead = new Lead(FirstName = 'John', LastName = 'Doe', Email = 'johndoe@example.com');
        insert testLead;

        // Create a test Attachment for the Lead
        Attachment testAttachment = new Attachment(
            ParentId = testLead.Id,
            Name = 'Retainer Agreement.pdf',
            Body = Blob.valueOf('Test file content'),
            ContentType = 'application/pdf'
        );
        insert testAttachment;

        // Mock values for the test
        String caseID = 'TEST123';
        String documentUploadEndpoint = 'https://example.com/upload';
        String apiKey = 'test-api-key';

        // Set the mock for sendDocument (using a stub to simulate the behavior)
        Test.startTest();

        // Execute the logic that processes attachments
        SmartAdvocateIntegration.processDocuments(caseID, testLead.Id, apiKey, documentUploadEndpoint);

        Test.stopTest();

        // Verify that the attachment was processed correctly
        List<Attachment> attachments = [SELECT Id, Name, Body FROM Attachment WHERE ParentId = :testLead.Id];

        // Check if the attachment exists in the database after processing
        System.assertEquals(1, attachments.size(), 'Attachment should exist in the database.');
    }
}