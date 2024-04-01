public class ReportController {
 //Generate report Based on parameter
 	@future(callout=true)
    public static void generateReport(String reportDevName, List<string> toAddressList) {
        try {
            List <Report> reportList = [SELECT Id, DeveloperName, Name FROM Report WHERE Name = :reportDevName];

            if(reportList.size() > 0) {
                //for (Report report : reportList) {
                    String reportId = reportList[0].Id;                   
                    //Get Report Name
                    string reportName = reportList[0].Name;                    
                    //get instance Url
                    String instanceName = URL.getOrgDomainUrl().toExternalForm();                    
                    string url = instanceName+'/servlet/PrintableViewDownloadServlet?isdtp=p1&reportId='+reportId;
                    
                    ApexPages.PageReference objPage = new ApexPages.PageReference(url);
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                    
                    Messaging.EmailFileAttachment objMsgEmailAttach = new Messaging.EmailFileAttachment();
                    objMsgEmailAttach.setFileName(reportName + '.csv');
                	if(Test.isRunningTest()) { 
 					 	objMsgEmailAttach.setBody(Blob.valueOf('Unit.Test'));
					} else {
  						objMsgEmailAttach.setBody(objPage.getContent());
					}                   
                    objMsgEmailAttach.setContentType('text/csv');
                    email.setSubject('Report results (' + reportName + ')');
                    
                    List<Messaging.EmailFileAttachment> attach = new List<Messaging.EmailFileAttachment>();
                    attach.add(objMsgEmailAttach);
                    email.setFileAttachments(attach);  
                    System.debug('email:: ' + email);
                    EmailService service = new EmailService(email);
                    service.body = 'Hello, <br/><br/> Here is attached ' + reportName + ' report.<br/><br/>Thank You,<br/>JRI team';
                    service.isHtml = true;
                    service.toAddresses = toAddressList; 
                    service.displayName = 'Salesforce Reports';
                    service.subject= 'Report results (' + reportName + ')';
                System.debug('service:: ' + service);
                    //emailMessages.add(email);
                    service.sendMail();
           		//}
           }
        }
        catch(Exception ex) {
            system.debug(ex.getMessage());
        }
    }
    
    public static void sendEmail(List <String> reportDevName) {
        List <String> listOfAddreses = new List<String>();
        listOfAddreses.add('erica@wearejri.com');  
        listOfAddreses.add('emina@wearejri.com');
        listOfAddreses.add('jamie@theevergreenmediagroup.com');
        listOfAddreses.add('Marc@theevergreenmediagroup.com');
        listOfAddreses.add('cassie@theevergreenmediagroup.com');
        listOfAddreses.add('kate@theevergreenmediagroup.com');
        listOfAddreses.add('alec@wearejri.com');
        
        for ( String report : reportDevName) {
            generateReport(report, listOfAddreses);
        }
    }
}