public with sharing class LeadTriggerHandler {
    public static void sendRetainerOnStatusUpdate(Id recordId){
        List <Lead> leadRec = [SELECT Id, Email, Name, Company__c, Campaign__c, Campaign__r.Name, Retainer_to_Send__c FROM Lead WHERE Id = :recordId AND Company__r.Name = 'Saddle Rock' AND (Campaign__r.Name = 'NEC' OR Campaign__r.Name = 'Roundup') WITH SECURITY_ENFORCED];

        if(leadRec != null && !leadRec.isEmpty() && leadRec[0]?.Campaign__r?.Name == 'NEC') {
            if (leadRec[0].Retainer_to_Send__c == 'TH: Child DOB 2002-2005 & lives in Missouri or Illinois') {
                SendSignatureRequestWithTemplate.generateHelloSignature(leadRec[0].Email, leadRec[0].Name, leadRec[0].Id, 'SR NEC - TH - adult child self - lives in MI or IL');
            } else if (leadRec[0].Retainer_to_Send__c == 'KP: Child DOB 2006-Present & lives in any state (Parent Filling for Child who is minor)') {
                SendSignatureRequestWithTemplate.generateHelloSignature(leadRec[0].Email, leadRec[0].Name, leadRec[0].Id, 'SR NEC - KP - parent filing obo minor - lives in any state');
            } else if (leadRec[0].Retainer_to_Send__c == 'KP: Child DOB 2006-Present & lives in any state (Child filling for themselves who is an adult)') {
                SendSignatureRequestWithTemplate.generateHelloSignature(leadRec[0].Email, leadRec[0].Name, leadRec[0].Id, 'SR NEC - KP - adult child self - lives in any state');
            } else if (leadRec[0].Retainer_to_Send__c == 'KP: Child DOB 2006-Present & lives in any state (Parent filling in addition to adult child) - *Adult child must also sign, if this is the case please fill out an intake for both'){
                SendSignatureRequestWithTemplate.generateHelloSignature(leadRec[0].Email, leadRec[0].Name, leadRec[0].Id, 'SR NEC - KP - parent obo self - lives in any state (Adult child must also sign)');
            } else if (leadRec[0].Retainer_to_Send__c == 'KKP: Child DOB 2006-Present & lives in Florida (Parent Filling for Child who is minor)') {
                SendSignatureRequestWithTemplate.generateHelloSignature(leadRec[0].Email, leadRec[0].Name, leadRec[0].Id, 'SR NEC - KP - parent filing obo minor - lives in FL');
            } else if (leadRec[0].Retainer_to_Send__c == 'KP: Child DOB 2006-Present & lives in Florida (Child filling for themselves who is an adult)') {
                SendSignatureRequestWithTemplate.generateHelloSignature(leadRec[0].Email, leadRec[0].Name, leadRec[0].Id, 'SR NEC - KP - adult child self - lives in FL');
            } else if (leadRec[0].Retainer_to_Send__c == 'KP: Child DOB 2006-Present & lives in Florida (Parent filling in addition to adult child) - *Adult child must also sign, if this is the case please fill out an intake for both'){
                SendSignatureRequestWithTemplate.generateHelloSignature(leadRec[0].Email, leadRec[0].Name, leadRec[0].Id, 'SR NEC - KP - parent obo self - lives in FL (Adult child must also sign)');
            } else {
                return;
            }
        } else if (leadRec != null && !leadRec.isEmpty() && leadRec[0]?.Campaign__r?.Name == 'NEC') {
            if (leadRec[0].Retainer_to_Send__c == 'Kline Specter - Self - FL') {
                SendSignatureRequestWithTemplate.generateHelloSignature(leadRec[0].Email, leadRec[0].Name, leadRec[0].Id, 'Saddle Rock - Roundup - Self - FL');
            } else if (leadRec[0].Retainer_to_Send__c == 'Kline Specter - OBO - FL') {
                SendSignatureRequestWithTemplate.generateHelloSignature(leadRec[0].Email, leadRec[0].Name, leadRec[0].Id, 'Saddle Rock - Roundup - Loved one - FL');
            } else if (leadRec[0].Retainer_to_Send__c == 'Kline Specter - Self - any state') {
                SendSignatureRequestWithTemplate.generateHelloSignature(leadRec[0].Email, leadRec[0].Name, leadRec[0].Id, 'Saddle Rock - Roundup - Self - Any state');
            } else if (leadRec[0].Retainer_to_Send__c == 'Kline Specter - OBO - any state'){
                SendSignatureRequestWithTemplate.generateHelloSignature(leadRec[0].Email, leadRec[0].Name, leadRec[0].Id, 'Saddle Rock - Roundup - Loved one - Any state');
            } else {
                return;
            }
        }

    }
}