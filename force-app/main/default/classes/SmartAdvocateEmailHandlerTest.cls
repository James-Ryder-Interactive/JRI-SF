@isTest
public class SmartAdvocateEmailHandlerTest {
	@isTest
    static void testSendEmailOnRetainerSigned() {
        HttpCalloutMock mock = new HttpIntegrationMock();
        Test.setMock(HttpCalloutMock.class, mock);

        Lead testLead = TestDataFactory.createTestLead();
        ContentDocumentLink testAttachmentLink = TestDataFactory.createTestContentDocument(testLead);
        
        Test.startTest();
        SmartAdvocateEmailHandler.sendEmailOnRetainerSigned(new List<Id>{testLead.Id});
        Test.stopTest();
    }
}