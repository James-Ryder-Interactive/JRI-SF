public class MapToEvergreen {
    
    public static List<Object> mapToEvergreenFields(SObject record) {
        List<Object> output = new List<Object>();

            if (record instanceof Lead) {
                // Create an EvergreenModel with Lead fields
                output.add(new EvergreenModel((Lead)record));
            } else if (record instanceof Talc__c) {      
                // Create an EvergreenModel with Lead and Talc__c fields
                output.add(new EvergreenModelTalc((Talc__c)record));
                System.debug('Talc__c output :::' + output);
            } else if (record instanceof Camp_Lejeune__c) {                
                // Create an EvergreenModel with Lead and Camp_Lejeune__c fields
                output.add(new EvergreenModelCMPL((Camp_Lejeune__c)record));
                System.debug('Camp_Lejeune__c output :::' + output);
            } else if (record instanceof Tylenol__c) {                
                // Create an EvergreenModel with Lead and Camp_Lejeune__c fields
                output.add(new EvergreenModelAPAP((Tylenol__c)record));
                System.debug('Tylenol__c output :::' + output);
            }
        return output;
    }
    
    public static List<EvergreenDocumentModel> mapAttachmentToEvergreenFields(List<ContentDocumentLink> attachments) {
        List<EvergreenDocumentModel> output = new List<EvergreenDocumentModel>();

        for(ContentDocumentLink  attachment : attachments) {
            EvergreenDocumentModel intake = new EvergreenDocumentModel();
            ContentVersion contentVersion = [SELECT Title, FileType, VersionData, PathOnClient FROM ContentVersion WHERE ContentDocumentId = :attachment.ContentDocumentId AND IsLatest = true LIMIT 1];
            
            if (contentVersion != null) {
                EvergreenDocumentModel.Attachments attachmentItem = new EvergreenDocumentModel.Attachments();
                attachmentItem.Body = EncodingUtil.base64Encode(contentVersion.VersionData);
                attachmentItem.ContentType = contentVersion.FileType;
                attachmentItem.Name = contentVersion.Title;
                intake.attachments = new List<EvergreenDocumentModel.Attachments>{ attachmentItem };
			}
            intake.potentiallead = new EvergreenDocumentModel.Potentiallead();
            intake.potentiallead.PotentialLeadID = attachment.LinkedEntityId;
			
            output.add(intake);
        }
        return output;
    }
}