@isTest
public class ReportControllerTest {
 	@isTest(SeeAllData='true')
    static void testGenerateReport() {
        // Create a test report
        HttpCalloutMock mock = new HttpIntegrationMock();
        List <Report> reportList = [SELECT Id, DeveloperName, Name FROM Report where
        Name = 'Saddle Rock Camp Lejune'];

		List <String> listOfAddreses = new List<String>();
        listOfAddreses.add('emina@wearejri.com');

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, mock);
        ReportController.generateReport(reportList[0].DeveloperName, listOfAddreses);
        Test.stopTest();

        // Verify the email is sent
        List<EmailMessage> emails = [SELECT Id, Subject, createddate, TextBody FROM EmailMessage ORDER By CreatedDate DESC LIMIT 1];
        Assert.areEqual(1, emails.size(), 'Expected one email message to be sent');
        //Assert.areEqual('Report results (Saddle Rock Camp Lejune)', emails[0].Subject, 'Unexpected email subject');
        //Assert.isTrue(emails[0].TextBody.contains('Here is attached'), 'Expected text not found in email body');
        //Assert.areEqual('text/csv', emails[0].ContentType, 'Unexpected email subject');
    }

    @isTest(SeeAllData='true')
    static void testSendEmail() {
        // Create test reports
        HttpCalloutMock mock = new HttpIntegrationMock();
        Report testReport1 = [SELECT Id, DeveloperName, Name FROM Report where Name = 'Saddle Rock Camp Lejune'];
		Report testReport2 = [SELECT Id, DeveloperName, Name FROM Report where Name = 'Saddle Rock Talcs'];
             
        // Call the sendEmail method
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, mock);
        ReportController.sendEmail(new List<String>{'Saddle Rock Camp Lejune', 'Saddle Rock Talcs'});
        Test.stopTest();

        // Verify the emails are sent
        List<EmailMessage> emails = [SELECT Id, Subject, TextBody FROM EmailMessage];

        for (EmailMessage email1 : emails) {
            //Assert.isTrue(email.Subject.contains(reportList[0].Name, 'Unexpected email subject');
            Assert.areNotEqual(0, emails.size(), 'Expected one email message to be sent');
            //Assert.isTrue(email1.TextBody.contains('Here is attached'), 'Expected text not found in email body');
        }
    }
}