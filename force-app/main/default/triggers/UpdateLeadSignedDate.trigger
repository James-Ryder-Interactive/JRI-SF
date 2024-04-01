trigger UpdateLeadSignedDate on HelloSign__HelloSign_Signature_Request_Detail__c (after insert) {
    List<Lead> leadsToUpdate = new List<Lead>();
    List<Talc__c> talcsToUpdate = new List<Talc__c>();
    
    for (HelloSign__HelloSign_Signature_Request_Detail__c detail : Trigger.new) {
        HelloSign__HelloSign_Signature_Request__c parentRequest = 
            [SELECT Id, HelloSign__Lead__c, Talc__c
             FROM HelloSign__HelloSign_Signature_Request__c
             WHERE Id = :detail.HelloSign__HelloSign_Signature_Request__c];
        
        if (parentRequest.HelloSign__Lead__c != null) {
            Lead leadToUpdate = [SELECT Id, Date_Signed__c, Date_Retainer_Sent__c, Status FROM Lead WHERE Id = :parentRequest.HelloSign__Lead__c];
            if (detail.HelloSign__Event__c == 'Signed') {                
                leadToUpdate.Date_Signed__c = detail.HelloSign__Date__c;
                leadToUpdate.Status = 'Retainer signed';      
            } else if (detail.HelloSign__Event__c == 'Sent') {
				leadToUpdate.Date_Retainer_Sent__c = detail.HelloSign__Date__c;    
                leadToUpdate.Status = 'Retainer sent'; 	
            }
			leadsToUpdate.add(leadToUpdate);
        }
        
        if (parentRequest.Talc__c != null) {
            Talc__c talcToUpdate = [SELECT Id, Lead__r.Date_Signed__c, Lead__r.Date_Retainer_Sent__c, Lead__r.Status FROM Talc__c WHERE Id = :parentRequest.Talc__c];
            Lead leadToUpdate = [SELECT Id, Date_Signed__c, Date_Retainer_Sent__c, Status FROM Lead WHERE Id = :talcToUpdate.Lead__c];

            if (detail.HelloSign__Event__c == 'Signed') {                
                leadToUpdate.Date_Signed__c = detail.HelloSign__Date__c;
                leadToUpdate.Status = 'Retainer signed';
            } else if (detail.HelloSign__Event__c == 'Sent') {
                leadToUpdate.Date_Retainer_Sent__c = detail.HelloSign__Date__c;
                leadToUpdate.Status = 'Retainer sent';
            }
            leadsToUpdate.add(leadToUpdate);
        }
    }
    
    if (!leadsToUpdate.isEmpty()) {
        update leadsToUpdate;
    }
}