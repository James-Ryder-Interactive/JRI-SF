@isTest
public class EmailServiceTest {
 	@isTest
    static void testSendMail_hasAttachment_true() {
        // Set up test data
        // 
        
        Messaging.SingleEmailMessage testEmail = new Messaging.SingleEmailMessage();
        testEmail.setSubject('Test Subject');
        testEmail.setToAddresses(new List<String>{'test@example.com'});
        testEmail.setPlainTextBody('Test Body');

        Messaging.EmailFileAttachment objMsgEmailAttach = new Messaging.EmailFileAttachment();
        Blob pdfBody = Blob.valueOf('Unit.Test');
        
        objMsgEmailAttach.setFileName('Report.csv');
        objMsgEmailAttach.setBody(pdfBody);
        objMsgEmailAttach.setContentType('text/csv');
        System.debug('objMsgEmailAttach :: ' + objMsgEmailAttach);           
        List<Messaging.EmailFileAttachment> attach = new List<Messaging.EmailFileAttachment>();
        attach.add(objMsgEmailAttach);
        testEmail.setFileAttachments(attach); 
        
        // Create an instance of EmailService with the test email
        EmailService emailService = new EmailService(testEmail);
        emailService.isHtml = true; // Set other properties as needed
        emailService.isAttachment = true;
        List <String> listOfAddreses = new List<String>();
        listOfAddreses.add('emina@wearejri.com');  
        emailService.toAddresses = listOfAddreses;
        emailService.CCAddresses = listOfAddreses;
        emailService.body = 'Hello, <br/><br/> Here is attached  report.<br/><br/>Thank You,<br/>JRI team';
        emailService.displayName = 'Salesforce Reports';
        emailService.subject = 'Report results';
        Map<String,String> attachments = new Map<String,String>();
        attachments.put('Report.csv', 'Test Body');
        emailService.attachFiles = attachments;

        Test.startTest();
        emailService.sendMail();
        Test.stopTest();

        List<EmailMessage> emails = [SELECT Id, Subject, TextBody FROM EmailMessage];
        System.assertEquals(1, emails.size(), 'Expected one EmailMessage to be created');
    }
    
    @isTest
    static void testSendMail_hasAttachment_false() {
        // Set up test data
        EmailService emailService2 = new EmailService();
        emailService2.isHtml = false; // Set other properties as needed
        emailService2.isAttachment = false;
        List <String> listOfAddreses2 = new List<String>();
        listOfAddreses2.add('emina@wearejri.com');  
        emailService2.toAddresses = listOfAddreses2;
        emailService2.body = 'Hello, <br/><br/> Here is attached  report.<br/><br/>Thank You,<br/>JRI team';
        emailService2.displayName = 'Salesforce Reports';
        emailService2.subject= 'Report results';

        Test.startTest();
		emailService2.sendMail();
        Test.stopTest();

        List<EmailMessage> emails = [SELECT Id, Subject, TextBody FROM EmailMessage];
        System.assertEquals(1, emails.size(), 'Expected one EmailMessage to be created');
    }
}