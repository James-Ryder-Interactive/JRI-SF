public with sharing class LeadController {
    @AuraEnabled
    public static List<Lead> getNECLeadsList() {
        return 
        [SELECT Id, FirstName, LastName, Company__c, Campaign__c, Status, Email, Phone, MobilePhone, Additional_Notes__c, Signature_Mail_Request__c, 
            Retainer_to_Send__c, Date_Retainer_Sent__c, Date_Signed__c, Intake_Specialist__c, Call_Outcome__c, Contacting_Consent__c, Caller_Recorded_Consent__c, SSN__c, Address,
        (SELECT Legal_Representation_Affirmation__c, Relation_To_Loved_One__c, Loved_One_Still_Living__c, Next_of_Kin__c, Death_Certificate__c,
            Date_Of_Passing__c, State_Of_Passing__c, Cause_Of_Death__c, Marital_Status__c, Emergency_Contact_Name__c, Emergency_Contact_Relationship__c, Emergency_Contact_Phone__c, Preferred_Communication_Method__c,
            Injured_Name__c, Injured_Gender__c, Injured_Date_Of_Birth__c, Injured_State__c, United_States_Resident__c 
            FROM Client_Information__r),
        (SELECT Birth_Weight__c, Pregnancy_Week_At_Birth__c, Diagnosed_in_Hospital__c, Diagnosis_Facility__c, Birth_Hospital__c, NEC_Primary_Symptom__c, NEC_Secondary_Symptom__c, NEC_Tertiary_Symptom__c,
            Formula_Fed_In_Hospital__c, NEC_After_Formula__c, Current_Child_Condition__c, NEC_Treatments__c, Abdominal_Surgeries__c, Mother_Name__c, Father_Name__c, Custody_Parenting_Issues__c, 
            Custody_Issues_Description__c, Pregnancy_Issues__c, Pregnancy_Issues_Description__c, NICU_Stay__c, NICU_Approx_Dates__c, NEC_Diagnosis__c, Diagnosis_Date__c
            FROM Medical_Information__r),
        (SELECT Lead__c FROM Case_Details__r)    
        FROM Lead WHERE Campaign__r.Name = 'NEC' AND Company__r.Name = 'Saddle Rock'];
    }
}