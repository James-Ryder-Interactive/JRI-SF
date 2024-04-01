public class SmartAdvocateEmailHandler {
    @InvocableMethod(label='Send Email on Retainer Signed' description='Sends email when lead status for Roundup leads is retainer signed')
    public static void sendEmailOnRetainerSigned(List<Id> leadIds) {

        // Query Lead records based on the provided Ids
        List<Lead> leadsToUpdate = [SELECT Id, LastName, FirstName, Email FROM Lead WHERE Id IN :leadIds];

        // Loop through queried Lead records
        for (Lead leadRecord : leadsToUpdate) {
            // Query attachments related to the Lead
            List<ContentDocumentLink> attachments = [SELECT Id, ContentDocumentId 
                                                     FROM ContentDocumentLink 
                                                     WHERE LinkedEntityId = :leadRecord.Id];

            // Create a new email message
            Messaging.SingleEmailMessage emailMessage = new Messaging.SingleEmailMessage();

            // Set email attributes
            emailMessage.setToAddresses(new String[]{'roundup@krauseandkinsman.com'});
            emailMessage.setSubject('CTG RU Retainer Packet – ' + leadRecord.LastName + ', ' +  leadRecord.FirstName);
            emailMessage.setPlainTextBody('CTG RU Retainer Packet – ' + leadRecord.LastName + ', ' +  leadRecord.FirstName);

            // List to hold email attachments
            List<Messaging.EmailFileAttachment> emailAttachments = new List<Messaging.EmailFileAttachment>();

            // Loop through queried attachments
            for (ContentDocumentLink attachment : attachments) {
                ContentVersion contentVersion = [SELECT Id, Title, FileType, VersionData, PathOnClient 
                                                 FROM ContentVersion 
                                                 WHERE ContentDocumentId = :attachment.ContentDocumentId 
                                                 AND IsLatest = true LIMIT 1];

                // Check if content version is available
                if (contentVersion != null) {
                    // Create an email attachment
                    Messaging.EmailFileAttachment emailAttachment = new Messaging.EmailFileAttachment();
                    emailAttachment.setFileName(contentVersion.Title);
                    emailAttachment.setBody(contentVersion.VersionData);
                    if (contentVersion.FileType == 'PDF') {
                        emailAttachment.setContentType('application/pdf');
                    }
                    

                    // Add the email attachment to the list
                    emailAttachments.add(emailAttachment);
                }
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