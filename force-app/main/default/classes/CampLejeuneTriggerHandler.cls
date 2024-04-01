public class CampLejeuneTriggerHandler {
    
	public static void sendCMPLRecordsToEvergreen(Id recordId){
     	List <Camp_Lejeune__c> newCMPLRecord = [SELECT Lead__c, Lead__r.Id, Lead__r.FirstName, Lead__r.MiddleName, Lead__r.LastName, Lead__r.City,Lead__r.State, Lead__r.Street, Lead__r.PostalCode,
                                    Lead__r.Phone, Lead__r.Email, Lead__r.Status, Lead__r.CreatedDate, Lead__r.Calling_for_yourself__c, Lead__r.Signature_Mail_Request__c, Lead__r.Time_Zone__c,
                                    Lead__r.Additional_Notes__c, Lead__r.Caller_Recorded_Consent__c, Other_Name__c, Relation_with_Client__c, Caller_Has_Authority_to_Sign__c, Lead__r.Contacting_Consent__c ,
                                    Client_Date_Of_Birth__c, Is_Person_Deceased__c, Date_Of_Passing__c, Cause_Of_Death__c,
                                    SSN__c, Secondary_Email__c, Alternate_Phone__c, Preferred_Communication_Methods__c, Best_Time_to_Reach__c,
                                    Emergency_Contact_Name__c, Emergency_Contact_Phone__c, Marital_Status__c, 
                                    Fiduciary_Name__c, Fiduciary_Contact_Relationship__c, Fiduciary_Phone__c,
                                    Co_Living_Emergency_Contact_Name__c, Co_Living_Emergency_Contact_Phone__c,
                                    Non_Co_Living_Emergency_Contact_Name__c, Non_Co_Living_Emergency_Contact_Phone__c,
                                    Currently_Represented_by_Attorney__c, Resident_of_the_United_States__c, Injured_Party_Affiliation__c,
                                    Presence_at_Camp_Lejeune_Details__c, Military_Details__c, Camp_Lejeune_Residence_Work_History__c,
                                    In_Utero_At_Camp_Lejeune__c, First_Exposure_Date__c, Last_Exposure_Date__c, Worked_or_Resided_at_Camp_Lejeune__c, Military_Family_Member_Full_Name__c,
                                    Exposure_To_Contaminated_Water__c, Location_At_Camp_Lejeune__c, Records_to_Substantiate_Camp_Time__c,
                                    Tier_1_Diagnoses__c, Tier_2_Diagnoses__c, Miscarriages_Fertility_Pregnancy_Issues__c,Tier_3_Diagnoses__c, Tier_4_Diagnoses__c, Tier_5_Diagnoses__c,
                                    Kidney_Cancer_Diagnosis_Date__c, Kidney_Disease_Diagnosis_Date__c, Leukemia_Diagnosis_Date__c,
                                    Liver_Cancer_Diagnosis_Date__c, Multiple_Myeloma_Diagnosis_Date__c, Non_Hodgkin_Lymphoma_Diagnosis_Date__c,
                                    Parkinson_s_Disease_Diagnosis_Date__c, Systemic_Sclerosis_Diagnosis_Date__c, Esophageal_Cancer_Diagnosis_Date__c,
                                    Lung_Cancer_Diagnosis_Date__c, Breast_Cancer_Male_Diagnosis_Date__c, Miscarriage_Fetal_Death_Diagnosis_Date__c,
                                    Congenital_Cardiac_Defect_Diagnosis_Date__c, Other_Serious_Birth_Defects_Diagnosis_Da__c,
                                    Brain_Cancer_Diagnosis_Date__c, Cervical_Cancer_Diagnosis_Date__c, Prostate_Cancer_Diagnosis_Date__c,
                                    Ovarian_Cancer_Diagnosis_Date__c, Liver_Disease_Diagnosis_Date__c, Hodgkin_s_Disease_Diagnosis_Date__c,
                                    Rectal_Cancer_Diagnosis_Date__c, Soft_Tissue_Cancer_Diagnosis_Date__c, Neurobehavioral_Effects_Diagnosis_Date__c,
                                    ALS_Diagnosis_Date__c, Bile_Duct_Cancer_Diagnosis_Date__c, Colon_Cancer_Diagnosis_Date__c,
                                    Laryngeal_Cancer_Diagnosis_Date__c, Oral_Cancer_Diagnosis_Date__c, Pharyngeal_Cancer_Diagnosis_Date__c,
                                    Pancreatic_Cancer_Diagnosis_Date__c, Thyroid_Cancer_Diagnosis_Date__c, Autoimmune_Disease_Diagnosis_Date__c,
                                    Neurological_Effects_Diagnosis_Date__c, Neurobehavioral_Deficits_Diagnosis_Date__c, Infertility_Diagnosis_Date__c,
                                    Low_Sperm_Count_Diagnosis_Date__c, Hypersensitivity_Skin_Diagnosis_Date__c, Lupus_Diagnosis_Date__c,Multiple_Sclerosis_Diagnosis_Date__c, Non_Co_Living_Emergency_Contact_Relation__c,
                                    Doctors_and_Specialties__c, Treatment_Facility_Information__c, Pharmacy_Information__c, Have_Camp_Lejeune_Documents__c, Affirmation_of_Exclusive_Representation__c,
                                    Received_Benefits__c, Aplastic_Anemia_Diagnosis_Date__c, Emergency_Contact_Relation__c, Co_Living_Emergency_Contact_Relationship__c FROM Camp_Lejeune__c WHERE Id = :recordId];
        
		if (newCMPLRecord != null && !newCMPLRecord.isEmpty()) {
            List<Object> evergreenModels = MapToEvergreen.mapToEvergreenFields(newCMPLRecord[0]);
            // Convert EvergreenModel to JSON
            String evergreenModelsJson = JSON.serialize(evergreenModels[0]);

            // Asynchronously send data to the external system
            EvergreenIntegration.sendLeadDataAsync(evergreenModelsJson);
        }
	}
}