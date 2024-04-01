public class RoundupTriggerHandler {
    
    public static void sendDataToSmartAdvocate(Id recordId) {
		List <Roundup__c> newRecord = [SELECT Id, OwnerId, Lead__r.CreatedDate, Name, Power_of_Attorney__c, City_and_State_Deceased__c, Confirm_Date_of_Death__c,
                Occupation__c, Begin_Smoking_Date__c, Years_Smoked__c, Packs_of_Cigarettes_Per_Day__c, Any_Other_Tobacco_Products__c, Quit_Smoking_Date__c,
                Injured_Party_Gender__c, Referral_Law_Firm__c , Best_Time_to_Reach__c, Caller_Date_of_Birth__c, Emergency_Contact_Name__c, Weight_at_Date_of_Diagnosis__c, Height_at_Date_of_Diagnosis__c,  
                Emergency_Contact_Relationship__c, Relationship_with_Injured_Contact__c, Emergency_Contact_Phone__c, 
                Injured_Contact_Name__c, Injured_Contact_Date_of_Birth__c, Current_Representation__c, Diagnosed_with_NHL__c, 
                NHL_Subtype__c, NHL_Diagnosis_Year__c, NHL_Diagnosis_Stage__c, Injured_Party_Deceased__c, Diagnosed_Before_2014__c, 
                Cause_of_Death__c, Diagnosed_Before_2004__c, Age_at_Diagnosis__c, Medical_Record_Available__c, Provider_Name__c, 
                Provider_Phone_Number__c, Provider_Address__c, Last_Treatment_Date__c, First_Treatment_Date__c, Surgeon_Information__c, 
                Oncologist_Information__c, PCP_Information__c, Treatment_Received__c, State_of_Residence_during_Treatments__c, 
                Pre_existing_Conditions__c, Are_you_a_smoker__c, States_Roundup_Used__c, Roundup_Usage_Location__c, Employer_Name__c, 
                Employer_Address__c, Employer_Phone_Number__c, Roundup_First_Exposure_Date__c, Roundup_Frequency_per_Year__c, 
                Roundup_Last_Exposure_Date__c, Roundup_Total_Years_Used__c, Roundup_Stop_Reason__c, Roundup_Exposure_Type__c, 
                Roundup_Type_Used__c, Roundup_Application_Method__c, Roundup_Application_Area_Size__c, Roundup_Purchase_Details__c,
                Chemotherapy_Treatment_Information__c, Chemotherapy_Start_Date__c, Chemotherapy_End_Date__c, Treatment_Provider_Name__c,
                Treatment_Provider_Address__c, Treatment_Provider_Phone__c, Additional_Specialist_Information__c, Surgeon_Name__c, Surgeon_Address__c,
                Oncologist_Name__c, Oncologist_Address__c, PCP_Name__c, PCP_Address__c, Proof_of_Purchase_Information__c, 
                Lead__c, Lead__r.Additional_Notes__c, Lead__r.Intake_Specialist__c, Lead__r.FirstName, Lead__r.LastName, Lead__r.Email,
                Lead__r.Phone, Lead__r.Address, Lead__r.Street, Lead__r.City, Lead__r.State, Lead__r.Country, Lead__r.PostalCode,
                Employer_City__c, Employer_State__c, Employer_Zip__c, Treatment_Provider_City__c, Treatment_Provider_State__c, Treatment_Provider_Zip__c,
                Surgeon_City__c, Surgeon_State__c, Surgeon_Zip__c, Oncologist_City__c, Oncologist_State__c, Oncologist_Zip__c, PCP_State__c, PCP_City__c, PCP_Zip__c,
                Additional_Medical_History__c, Lead__r.SSN__c FROM Roundup__c WHERE Id = :recordId];
        
        Lead relatedLead = [Select Id, Name from Lead where Id = :newRecord[0].Lead__c];
    	List<Object> roundupModels = SmartAdvocateModel.mapToSmartAdvocateFields(newRecord);
    	String smartAdvocateModelJson = JSON.serialize(roundupModels[0]);

    	// Asynchronously send data to the external system
        sendLeadDataWithDelay(smartAdvocateModelJson, relatedLead.Id);
   }
    
    public static void sendLeadDataWithDelay(String smartAdvocateModelJson, String leadId) {
        System.debug('Uslo u sendLeadDataWithDelay');
        // Introduce a delay before calling sendLeadDataAsync
        String year = String.valueOf(Datetime.now().year());
        String month = Datetime.now().format('MMM').toUpperCase();
        String day = String.valueOf(Datetime.now().day());
        String hour = String.valueOf(Datetime.now().hour());
		String min = String.valueOf(Datetime.now().minute() + 2);
		String ss = String.valueOf(Datetime.now().second());

        String nextFireTime = ss + ' ' + min + ' ' + hour + ' ' +  day + ' ' + month + ' ? ' + year;
        System.debug('nextFireTime ::: ' + nextFireTime);

        try {
        	System.schedule('ScheduleRoundupIntegration_' + leadId + System.now(), nextFireTime, new ScheduleRoundupIntegration(smartAdvocateModelJson, leadId));
        } catch (Exception ex) {
            System.debug( 'Error scheduling apex job : ' + ex.getMessage());            
        }
    }        
}