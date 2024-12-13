public with sharing class FormMetadataController {

    @AuraEnabled(cacheable=true)
    public static List<Map<String,Object>> getFormQuestions(String formName) {
        // Query the FormQuestion__c custom object based on the provided formName
        List<Form_Metadata__mdt> formMetadataList  = [
            SELECT Form_Name__c, Label, Questions_JSON__c
            FROM Form_Metadata__mdt
            WHERE Form_Name__c = :formName
            LIMIT 1
        ];

        // Return an empty list if no metadata is found
        if (formMetadataList.isEmpty()) {
            return new List<Map<String, Object>>();
        }

        Form_Metadata__mdt formMetadata = formMetadataList[0];
        List<Map<String, Object>> sections = new List<Map<String, Object>>();

        try {
            // Deserialize the JSON into an Object
            Map<String, Object> formMap = (Map<String, Object>) JSON.deserializeUntyped(formMetadata.Questions_JSON__c);
            
            // Access the "questions" key and ensure it’s cast as a List<Map<String, Object>>
            if (formMap.containsKey('sections') && formMap.get('sections') instanceof List<Object>) {
                List<Object> sectionsList = (List<Object>) formMap.get('sections');
                
                // Iterate through each section and cast to Map<String, Object>
                for (Object section : sectionsList) {
                    Map<String, Object> sectionMap = (Map<String, Object>) section;
                    
                    // Get questions within each section
                    if (sectionMap.containsKey('questions') && sectionMap.get('questions') instanceof List<Object>) {
                        List<Object> questionsList = (List<Object>) sectionMap.get('questions');
                        List<Map<String, Object>> questions = new List<Map<String, Object>>();
                        
                        // Cast each question to Map<String, Object>
                        for (Object question : questionsList) {
                            questions.add((Map<String, Object>) question);
                        }
                        
                        // Add the questions list back into the section
                        sectionMap.put('questions', questions);
                    }                   
                    // Add the section to the sections list
                    sections.add(sectionMap);
                }              
                return sections;
            }
        } catch (Exception e) {
            // Log any errors encountered during JSON processing
            System.debug('Error processing form sections: ' + e.getMessage());
            return new List<Map<String, Object>>();
        }
        
        // Return an empty list if no form metadata was found
        return new List<Map<String, Object>>();
    }

    @AuraEnabled
    public static Id saveFormResponse(Map<String, String> formData) {
        Lead lead = new Lead();
        lead.FirstName = formData.get('First Name');
        lead.LastName = formData.get('Last Name');
        // Add other fields as needed based on your questions
        insert lead;
        return lead.Id;
    }
}