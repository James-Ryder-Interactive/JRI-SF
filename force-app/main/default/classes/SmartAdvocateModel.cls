public class SmartAdvocateModel {
//This was for sending Roundup records
    public static List<Object> mapToSmartAdvocateFields(List<Roundup__c> records){
        List<Object> output = new List<Object>();
        
        //This was for sending Roundup records : This is not needed anymore
        for(Roundup__c record : records){
            Object intake;
            Map<String, String> mapToConvert = new Map<String, String>();
            mapToConvert.put('email', record.Lead__r.Email);
            mapToConvert.put('firstName', record.Lead__r.FirstName);
            mapToConvert.put('lastName', record.Lead__r.LastName);
            mapToConvert.put('phone', record.Lead__r.Phone);
            mapToConvert.put('Paid Advertisement', String.valueOf('RU: Consumer Tort Group (KKG)'));
            mapToConvert.put('Referral Law Firm', record.Referral_Law_Firm__c );
            mapToConvert.put('Referred Out Law Firm', 'Kline and Specter, PC');
            mapToConvert.put('Address', record.Lead__r.Street);
            mapToConvert.put('city', record.Lead__r.City);
            mapToConvert.put('state', record.Lead__r.State);
            mapToConvert.put('zip', record.Lead__r.PostalCode);
            mapToConvert.put('Intake Date', String.valueOF(record.Lead__r.CreatedDate));
            mapToConvert.put('dob', String.valueOF(record.Caller_Date_of_Birth__c));
            mapToConvert.put('gender', record.Injured_Party_Gender__c);
            mapToConvert.put('caseType', 'Roundup Herbicide');
            mapToConvert.put('ReferralLawFirm', record.Referral_Law_Firm__c);
            mapToConvert.put('PaidAdvertising', 'RU: Consumer Tort Group (KKG)');
            mapToConvert.put('ReferOutFirm', 'Kline and Specter, PC');

            mapToConvert.put('Agent Notes', record.Lead__r.Additional_Notes__c);
            mapToConvert.put('Agent Performing Interview Name', record.Lead__r.Intake_Specialist__c);
            mapToConvert.put('Best Contact Time', record.Best_Time_to_Reach__c);
            mapToConvert.put('POC Relationship to Injured Party', record.Relationship_with_Injured_Contact__c);
            mapToConvert.put('Best Contact Time POC', record.Best_Time_to_Reach__c); 
            mapToConvert.put('POC has Power of Attorney', record.Power_of_Attorney__c);
            mapToConvert.put('Is the injured party deceased?', record.Injured_Party_Deceased__c);
            mapToConvert.put('Confirm Date of Death in Contact Card', record.Confirm_Date_of_Death__c);
            mapToConvert.put('City and State where plaintiff was deceased (for example: Kansas City, MO):', record.City_and_State_Deceased__c);
            mapToConvert.put('Cause of Death', record.Cause_of_Death__c);
            mapToConvert.put('Emergency Contact First & Last Name', record.Emergency_Contact_Name__c);
            mapToConvert.put('Emergency Contact Relationship to Injured Party', record.Emergency_Contact_Relationship__c);
            mapToConvert.put('Emergency Contact Number', record.Emergency_Contact_Phone__c);
            mapToConvert.put('Exposure Type - Commercial/Residential', record.Roundup_Usage_Location__c);
            mapToConvert.put('Exposure Date To', record.Roundup_Last_Exposure_Date__c);
            mapToConvert.put('Exposure Date From', record.Roundup_First_Exposure_Date__c);
            mapToConvert.put('Duration of Exposure', record.Roundup_Total_Years_Used__c);
            mapToConvert.put('Location of Exposure', record.States_Roundup_Used__c);
            mapToConvert.put('Employer Name', record.Employer_Name__c);
            mapToConvert.put('Employer Address', record.Employer_Address__c);
            mapToConvert.put('Employer City', record.Employer_City__c);
            mapToConvert.put('Employer State', record.Employer_State__c);
            mapToConvert.put('Employer Zip', record.Employer_Zip__c);
            mapToConvert.put('Are you a Non-Smoker, Current Smoker, or Former Smoker?', record.Are_you_a_smoker__c);
            mapToConvert.put('Occupation', record.Occupation__c);
            mapToConvert.put('Occupation Other', record.Occupation__c);
            mapToConvert.put('When did you begin smoking?', String.valueOf(record.Begin_Smoking_Date__c));
            mapToConvert.put('If Current Smoker, how long have you smoked?', record.Years_Smoked__c);
            mapToConvert.put('Approximately how many packs of cigarettes a day did you smoke?', record.Packs_of_Cigarettes_Per_Day__c);
            mapToConvert.put('Any other tobacco products?', record.Any_Other_Tobacco_Products__c);
            mapToConvert.put('If Former Smoker, approximately when did you quit?', String.valueOf(record.Quit_Smoking_Date__c));
            //mapToConvert.put('Proof of Use', record.Cause_of_Death__c);
            
            mapToConvert.put('Type of Cancer', record.NHL_Subtype__c);
            if(record.NHL_Subtype__c != null) {
                mapToConvert.put('Other Cancer', record.NHL_Subtype__c.contains('Other') ? record.NHL_Subtype__c : '');
            }
            mapToConvert.put('Cancer Stage', record.NHL_Diagnosis_Stage__c);
            mapToConvert.put('Diagnosis Date', String.valueOf(record.NHL_Diagnosis_Year__c));
            mapToConvert.put('Height at Date of Diagnosis', record.Height_at_Date_of_Diagnosis__c);
            mapToConvert.put('Weight at Date of Diagnosis', record.Weight_at_Date_of_Diagnosis__c);
            mapToConvert.put('First Treatment Date', String.valueOf(record.First_Treatment_Date__c));
            mapToConvert.put('Last Treatment Date', String.valueOf(record.Last_Treatment_Date__c));
            mapToConvert.put('Chemotherapy Treatment Information', record.Chemotherapy_Treatment_Information__c);
			mapToConvert.put('Chemotherapy Start Date', String.valueOf(record.Chemotherapy_Start_Date__c));
			mapToConvert.put('Chemotherapy End Date', String.valueOf(record.Chemotherapy_End_Date__c));
            mapToConvert.put('Residence State During Treatments', record.State_of_Residence_during_Treatments__c);
			mapToConvert.put('Treatment Provider Name', record.Treatment_Provider_Name__c);
            mapToConvert.put('Treatment Provider Address', record.Treatment_Provider_Address__c);
            mapToConvert.put('Treatment Provider Phone', record.Treatment_Provider_Phone__c);
            mapToConvert.put('Treatment Provider City', record.Treatment_Provider_City__c);
            mapToConvert.put('Treatment Provider State', record.Treatment_Provider_State__c);
            mapToConvert.put('Treatment Provider Zip', record.Treatment_Provider_Zip__c);
            mapToConvert.put('Surgeon Name', record.Surgeon_Name__c);
            mapToConvert.put('Surgeon Address', record.Surgeon_Address__c);
            mapToConvert.put('Surgeon City', record.Surgeon_City__c);
            mapToConvert.put('Surgeon State', record.Surgeon_State__c);
            mapToConvert.put('Surgeon Zip', record.Surgeon_Zip__c);
            mapToConvert.put('Oncologist Name', record.Oncologist_Name__c);
            mapToConvert.put('Oncologist Address', record.Oncologist_Address__c);
            mapToConvert.put('Oncologist City', record.Oncologist_City__c);
            mapToConvert.put('Oncologist State', record.Oncologist_State__c);
            mapToConvert.put('Oncologist Zip', record.Oncologist_Zip__c);
            mapToConvert.put('PCP Name', record.PCP_Name__c);
            mapToConvert.put('PCP Address', record.PCP_Address__c);
            mapToConvert.put('PCP State', record.PCP_State__c);
            mapToConvert.put('PCP City', record.PCP_City__c);
            mapToConvert.put('PCP Zip', record.PCP_Zip__c);
            mapToConvert.put('Additional Specialist Information', record.Additional_Specialist_Information__c);
            mapToConvert.put('Medical History', record.Additional_Medical_History__c); 
            mapToConvert.put('Please indicate if you have any of the following:', record.Pre_existing_Conditions__c);
            mapToConvert.put('SSN', record.Lead__r.SSN__c);
            intake = mapToConvert;
            output.add(intake);
        }
	
        return output;
    }

//This is for Marriot
    public static List<Object> mapToSmartAdvocateMarriot(List<Lead> records){
            // Prepare output list
        List<Object> output = new List<Object>();

        // Collect Lead IDs for related record queries
        Set<Id> leadIds = new Set<Id>();
        for (Lead lead : records) {
            leadIds.add(lead.Id);
        }

        // Query related Client__c and Case__c records
        /*Map<Id, Client__c> clientMap = new Map<Id, Client__c>([
            SELECT Id, Name, Lead__c
            FROM Client__c
            WHERE Lead__c IN :leadIds
        ]);*/

        /*Map<Id, Case__c> caseMap = new Map<Id, Case__c>([
            SELECT Id, Lead__c
            FROM Case__c
            WHERE Lead__c IN :leadIds
        ]);*/

        // Process each lead
        for (Lead lead : records) {
            if (lead.Company__r.Name == 'Marriott') { // Filter by Campaign name
                Map<String, String> mapToConvert = new Map<String, String>();

                // Add Lead fields
                mapToConvert.put('ID', lead.Id);

                mapToConvert.put('source', 'TMTLF - Marriott');
                mapToConvert.put('caseType', 'Marriott Privacy');
                mapToConvert.put('referralFirm', 'Sperling & Slater PC');
                mapToConvert.put('caseDetails', lead.Additional_Notes__c);
                mapToConvert.put('retainDate', String.valueOf(lead.Date_Signed__c));

                mapToConvert.put('firstName', lead.FirstName);
                mapToConvert.put('lastName', lead.LastName);
                mapToConvert.put('gender', lead.LastName);
                mapToConvert.put('dob', String.valueOf(lead.Date_of_Birth__c));
                mapToConvert.put('ssn', lead.SSN__c);
                mapToConvert.put('phone', lead.Phone);
                mapToConvert.put('email', lead.Email);
                mapToConvert.put('address', lead.Street);
                mapToConvert.put('city', lead.City);
                mapToConvert.put('state', lead.State);
                mapToConvert.put('zip', lead.PostalCode);

                mapToConvert.put('injuredFirstName', lead.FirstName);
                mapToConvert.put('injuredLastName', lead.LastName);
                mapToConvert.put('injuredGender', lead.LastName);
                mapToConvert.put('injuredDoB', String.valueOf(lead.Date_of_Birth__c));
                mapToConvert.put('injuredSSN', lead.SSN__c);
                mapToConvert.put('injuredPhone', lead.Phone);
                mapToConvert.put('injuredEmail', lead.Email);
                mapToConvert.put('injuredAddress', lead.Street);
                mapToConvert.put('injuredCity', lead.City);
                mapToConvert.put('injuredState', lead.State);
                mapToConvert.put('injuredZip', lead.PostalCode);

                // Add Client__c fields (if exists)
                /*Client__c client = clientMap.get(lead.Id);
                if (client != null) {
                    //mapToConvert.put('Client Name', client.Name);
                }*/

                // Add Case__c fields (if exists)
                /*Case__c caseRec = caseMap.get(lead.Id);
                if (caseRec != null) {
                    //mapToConvert.put('Case Number', caseRec.CaseNumber);
                }*/

                // Add to output
                output.add(mapToConvert);
            }
        }

    return output;
    }
}