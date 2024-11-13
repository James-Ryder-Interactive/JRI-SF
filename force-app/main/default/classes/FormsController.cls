public with sharing class FormsController {
    @AuraEnabled(cacheable=true)
    public static List<Form__c> getForms() {
        return [SELECT Id, Name, Status__c, CreatedDate, Submission_Count__c FROM Form__c];
    }
        
    @AuraEnabled
    public static void saveFormAnswers(Map<String, String> formData) {
        // Initialize a new Lead record (or update an existing record)
        Lead lead = new Lead();
        
        // Map each form field to the Lead field
        for (String fieldApiName : formData.keySet()) {
            String value = formData.get(fieldApiName);
            lead.put(fieldApiName, value);
        }
        
        // Insert or update Lead record
        upsert lead;
    }

}