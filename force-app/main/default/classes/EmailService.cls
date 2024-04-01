public class EmailService {
 	public string subject {get;set;} // mail subject
    public List<String> toAddresses {get;set;} // send to
    public List<String> CCAddresses {get;set;} // cc 
    public String body {set;get;} // mail plain body
    public String displayName {set;get;} // from 
    public boolean isAttachment {set;get;} // if we have to send attachment file in mail
    public Map<String,String> attachFiles {set;get;} // key = attachmentName and value =attachmentBody 
    public boolean isHtml {set;get;}
    public List<Messaging.EmailFileAttachment> attachments; 
    public Messaging.SingleEmailMessage email;
    
    public EmailService(){
        attachments = new List<Messaging.EmailFileAttachment>();
        email = new Messaging.SingleEmailMessage();
        this.isAttachment=false;  
        this.isHtml=false;
    }
    public EmailService(Messaging.SingleEmailMessage mailMessage){
        attachments = new List<Messaging.EmailFileAttachment>();
        email = mailMessage;
        this.isAttachment = false;  
    }
    
    public void sendMail(){
        
        if(isAttachment && attachFiles != null){
            for (String name : attachFiles.keySet()){                
                Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
                blob csvBlob = Blob.valueOf(attachFiles.get(name));
                string csvname=name+'.csv';
                csvAttc.setContentType('text/csv');
                csvAttc.setFileName(csvname);
                csvAttc.setBody(csvBlob);
                attachments.add(csvAttc);
            } 
        }
        email.setSubject(subject);
        email.setToAddresses(toAddresses);
        email.setSenderDisplayName(displayName);
        if(isHtml) {
            email.setHtmlBody(body);
        } else {
            email.setPlainTextBody(body);
        }
        if(isAttachment){
            email.setFileAttachments(attachments);  
        }
        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email}); 
        system.debug('Email sent');
    }
}