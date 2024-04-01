public class TylenolTriggerHandler {
	public static void sendTylenolRecordsToEvergreen(Id recordId) {
     	List <Tylenol__c> newTylenolRecord = [SELECT Lead__c, Lead__r.Id, Lead__r.FirstName, Lead__r.MiddleName, Lead__r.LastName, Lead__r.City,Lead__r.State, Lead__r.Street, Lead__r.PostalCode, Lead__r.Time_Zone__c,
                                    Lead__r.Phone, Lead__r.Contacting_Consent__c, Lead__r.Email, Lead__r.Status, Lead__r.CreatedDate, Lead__r.Calling_for_yourself__c, Lead__r.Signature_Mail_Request__c,
                                    Lead__r.Additional_Notes__c, Lead__r.Caller_Recorded_Consent__c, Accurate_Information_Agreement__c, Relationship_with_Client__c, Client_Name__c, 
                                    Date_of_Birth__c, Gender__c, Child_s_SSN__c, Is_Person_Deceased__c, Has_Power_of_Attorney__c, Is_Next_of_Kin__c, Date_of_Passing__c, Mother_s_Date_of_Birth__c, 
                                    Alternate_Contact_Number__c, Represented_by_Law_Firm__c, Trimester_of_Tylenol_Use__c, Tylenol_Acetaminophen_Taken__c, Tylenol_Brand__c, Generic_Acetaminophen_Store__c, 
                                    Other_Generic_Acetaminophen_Store__c, Frequency_of_Tylenol_Use__c, Child_Born_After_Week_26__c, Child_s_Birth_Week__c, Child_s_Current_Age__c, 
                                    Child_Formally_Diagnosed__c, Type_of_Disorder__c, Child_s_Diagnosis_Date__c, Diagnosing_Physician_Hospital_Address__c, Child_s_Birth_Facility_and_Address__c, 
                                    Child_s_Birth_City__c, Child_s_Birth_State__c, Child_s_Birth_Zip__c, Child_Diagnosed_with_ADHD__c, ADHD_Medication_Brand__c, ADHD_Medication_Dosage__c, 
                                    ADHD_Medication_Duration__c, Other_Behavioral_Psychological_Issues__c, Issue_Description_and_Severity__c, Child_Held_Back_in_School__c, Tutoring_Therapy_Expenses__c, 
                                    Other_ADHD_Issues_Concerns__c, Specific_Diagnoses__c, Complications_During_Pregnancy__c, Substance_Use_During_Pregnancy__c, Your_Age_at_Baby_s_Birth__c, Mother_s_Full_Name__c, 
                                    Father_s_Full_Name__c, Father_s_Age_at_Baby_s_Birth__c, Diagnosed_with_Autism_or_ADHD__c, Mother_s_SSN__c, Emergency_Contact_Name__c, Emergency_Contact_Relationship__c, 
                                    Emergency_Phone__c FROM Tylenol__c WHERE Id = :recordId];
        
		if (newTylenolRecord != null && !newTylenolRecord.isEmpty()) {
            List<Object> evergreenModels = MapToEvergreen.mapToEvergreenFields(newTylenolRecord[0]);
            // Convert EvergreenModel to JSON
            String evergreenModelsJson = JSON.serialize(evergreenModels[0]);

            // Asynchronously send data to the external system
            EvergreenIntegration.sendLeadDataAsync(evergreenModelsJson);
        }
	}
}