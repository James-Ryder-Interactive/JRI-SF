public class SmartAdvocateEmailHandler {
    @InvocableMethod(label='Send Email on Retainer Signed' description='Sends email when lead status for leads is retainer signed')
    public static void sendEmailOnRetainerSigned(List<Id> leadIds) {

        // Query Lead records based on the provided Ids
        List<Lead> leadsToUpdate = [SELECT Id, LastName, FirstName, Email FROM Lead WHERE Id IN :leadIds];

        // Loop through queried Lead records
        for (Lead leadRecord : leadsToUpdate) {
            // Query attachments related to the Lead (ContentVersion + Attachment)
            List<ContentDocumentLink> contentDocumentLinks = [
                SELECT Id, ContentDocumentId 
                FROM ContentDocumentLink 
                WHERE LinkedEntityId = :leadRecord.Id
            ];

            // Query all attachments related to the Lead
            List<Attachment> attachmentList = [
                SELECT Id, Name, Body, ContentType 
                FROM Attachment 
                WHERE ParentId = :leadRecord.Id
            ];

            // Create a new email message
            Messaging.SingleEmailMessage emailMessage = new Messaging.SingleEmailMessage();

            // Set email attributes
            emailMessage.setToAddresses(new String[]{'campaigns@hilliard-law.com', 'jrodriguez@hilliard-law.com', 'emina@wearejri.com'});
            emailMessage.setSubject('Marriott Privacy Violations - Hilliard - Legal Settlement Experts – ' + leadRecord.LastName + ', ' +  leadRecord.FirstName);
            emailMessage.setPlainTextBody('Hello,'  + '\n' + 'Please find client intake responses attached in .pdf format' + '\n\n' +
                'Thank you' + '\n' + 'Legal Settlement Experts');

            // List to hold email attachments
            List<Messaging.EmailFileAttachment> emailAttachments = new List<Messaging.EmailFileAttachment>();

            // Process ContentDocumentLinks (ContentVersion)
            for (ContentDocumentLink docLink : contentDocumentLinks) {
                ContentVersion contentVersion = [
                    SELECT Id, Title, FileType, VersionData, PathOnClient 
                    FROM ContentVersion 
                    WHERE ContentDocumentId = :docLink.ContentDocumentId 
                    AND IsLatest = true 
                    LIMIT 1
                ];

                // Process ContentVersion (add as email attachment)
                if (contentVersion != null) {
                    Messaging.EmailFileAttachment emailAttachment = new Messaging.EmailFileAttachment();
                    emailAttachment.setFileName(contentVersion.Title);
                    emailAttachment.setBody(contentVersion.VersionData);
                    //emailAttachment.setContentType('application/pdf'); // Set to the appropriate content type (adjust as needed)
                    // Set ContentType based on FileType
                    if (contentVersion.FileType == 'PDF') {
                        emailAttachment.setContentType('application/pdf');
                    } else {
                        emailAttachment.setContentType('application/octet-stream'); // Default ContentType for unsupported types
                    }
                    emailAttachments.add(emailAttachment);
                }
            }

            // Process regular Attachments
            for (Attachment att : attachmentList) {
                Messaging.EmailFileAttachment emailAttachment = new Messaging.EmailFileAttachment();
                emailAttachment.setFileName(att.Name);
                emailAttachment.setBody(att.Body);
                emailAttachment.setContentType(att.ContentType);
                emailAttachments.add(emailAttachment);
            }

            // Attach files to the email
            if (!emailAttachments.isEmpty()) {
                emailMessage.setFileAttachments(emailAttachments);
            }

            // Send the email
            Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{emailMessage});
        }
    }
}