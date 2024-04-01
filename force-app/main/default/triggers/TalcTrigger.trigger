trigger TalcTrigger on Talc__c (after insert) {
    for(Talc__c rec : Trigger.New){
        TalcTriggerHandler.processRecords(rec.Id);
    }
}