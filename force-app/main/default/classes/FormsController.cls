public with sharing class FormsController {
    @AuraEnabled(cacheable=true)
    public static List<Form__c> getForms() {
        return [SELECT Id, Name, Status__c, CreatedDate, Submission_Count__c FROM Form__c];
    }
        
    // Add additional methods here for delete functionality if needed

}