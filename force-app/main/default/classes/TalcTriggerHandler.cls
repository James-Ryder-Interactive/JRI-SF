public class TalcTriggerHandler {
    
	public static void sendTalcRecordsToEvergreen(Id recordId){
     	List <Talc__c> newTalcRecord = [SELECT Id, Name, Lead__c, Lead__r.Name, Lead__r.FirstName, Lead__r.MiddleName, Lead__r.LastName, Lead__r.City,Lead__r.State, Lead__r.Street, Lead__r.PostalCode, Lead__r.Time_Zone__c,
                                  Lead__r.Phone, Lead__r.Email, Lead__r.Status, Lead__r.CreatedDate, Lead__r.Calling_for_yourself__c, Lead__r.Signature_Mail_Request__c, Next_Of_Kin__c, CreatedDate, Any_other_significant_exposure__c, 
                                  Best_number_to_reach_you_at__c, Calling_for_yourself_or_someone_else__c, Lead__r.Caller_Recorded_Consent__c, Lead__r.Contacting_Consent__c, Lead__r.Additional_Notes__c,  
                                  Confirm_inormation_to_be_true__c, Injureds_Date_of_Birth__c, Injureds_Full_Legal_Name__c, Injureds_Gender__c, Injureds_date_of_death__c, 
                                  Injury_diagnosed_with__c, Is_Injured_deceased__c, Legal_authority_to_represent_Injured__c, Monthyear_started_using_product__c, Marital_Status__c, Alternate_Phone_Number__c, 
                                  Monthyear_stopped_using_product__c, Name_of_the_legal_authority__c, New_or_Existing_Client__c, Person_who_would_have_legal_authority__c, 
                                  Previously_represented_by_Attorney__c, What_monthyear_were_you_exposed__c, Willing_to_share_information__c, Your_relation_to_the_injured__c,Time_Zone__c, 
                                  Represented_by_a_lawyer__c, Injured_Person_or_a_Representative__c, Filed_Claim_in_Imerys_Bankruptcy__c, Filed_Lawsuit_for_Ovarian_Cancer__c, Where_did_you_apply_product__c,
                                  Formally_Released__c, Lawyer_Name_and_Contact_Information__c, Maiden_Other_Names_Used__c, Reason_for_Release__c, Release_Preference__c, SSN__c,Diagnosing_Doctor__c,Diagnosed_with_Obesity_Overweight__c,  
                                  Spouse_s_Name__c, Used_Johnson_Johnson_Powder__c, Used_Johnson_Johnson_Shower__c, Used_Other_Cosmetic_Powder_Products__c, Currently_Smoke_Cigarettes__c,Tested_for_the_BRCA1_or_BRCA2_mutation__c,
                                  Past_Smoked_Cigarettes__c, Best_Time_to_Reach__c, Ovaries_Removed_During_Surgery__c, Fallopian_Tubes_Removed_During_Surgery__c, Cancer_Type_at_Dx__c, Cancer_Stage_at_Dx__c, Diagnosed_with_Other_Cancer__c,  
                                  Family_History_Ovarian_Breast_Cancer__c, Family_History_Genetic_Mutations__c, Represented_By_Law_Firm__c, Had_a_Tubal_Ligation__c, Time_of_Connection_Awareness__c,
                                  First_diagnosed_hysterectomy__c, First_diagnosed_lung_cancer__c, First_diagnosed_mesothelioma__c, First_diagnosed_omentum_cancer__c, First_diagnosed_ovarian_cancer__c, First_diagnosed_primary_peritoneal__c,
                                  First_diagnosed_uterine_cancer__c, First_diagnosed_uterine_fibroid__c, First_diagnosed_vaginal_cancer__c, First_diagnosed_vulvar_cancer__c, First_diagnosed_endometerial_cancer__c,
                                  First_diagnosed_fallopian_tube__c,First_diagnosed_cervical_cancer__c, Number_of_Unidentified_Cancer_Providers__c, Last_Visit_Year_PC_Prov_5__c, Number_of_Pharmacies_Used__c, 
                                  Number_of_Pre_cancer_Providers_Visited__c, Number_of_Providers__c FROM Talc__c WHERE Id = :recordId];
        
		if (newTalcRecord != null && !newTalcRecord.isEmpty()) {
            // Map Talc__c records to EvergreenModel
            List<Object> evergreenModels = MapToEvergreen.mapToEvergreenFields(newTalcRecord[0]);
            // Convert EvergreenModel to JSON
            String evergreenModelsJson = JSON.serialize(evergreenModels[0]);
            // Asynchronously send data to the external system
            EvergreenIntegration.sendLeadDataAsync(evergreenModelsJson);
        }
	}

    public static void processRecords(Id recordId){
        List <Lead> leadRec = [SELECT Id, Email, Name, Company__c, Campaign__c FROM Lead WHERE Id IN (SELECT Lead__c FROM Talc__c WHERE Id = :recordId) AND Company__r.Name = 'Saddle Rock' AND Campaign__r.Name = 'Talc'];
        
        if(leadRec != null && !leadRec.isEmpty()) {
        	SendSignatureRequestWithTemplate.generateHelloSignature(leadRec[0].Email, leadRec[0].Name, recordId, 'Saddle Rock- Talcum Powder- Please sign');
        }
    }
}