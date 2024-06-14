trigger RoundupTrigger on Roundup__c (after update) {
    for (Roundup__c roundupRecord : Trigger.new) {
        Roundup__c oldRoundupRecord = Trigger.oldMap.get(roundupRecord.Id);
		System.debug('Trigger is firing.');

        // Check if the status has changed to "Retainer signed"
        if (roundupRecord.Company__c == 'Kline & Specter' && roundupRecord.Status__c == 'Retainer signed' && oldRoundupRecord.Status__c != 'Retainer signed') {
			System.debug('Trigger is firing. Calling future method.');
            RoundupTriggerHandler.sendDataToSmartAdvocate(roundupRecord.Id);
        }
    }
}