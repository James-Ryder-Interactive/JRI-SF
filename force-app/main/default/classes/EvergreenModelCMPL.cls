public class EvergreenModelCMPL extends EvergreenModel {
        
    //Fields specific to CampLejeune
    public String AuthorizedEmergencyContactFirst;
    public String AuthorizedEmergencyContactMiddle;
    public String AuthorizedEmergencyContactLast;
    public String EmergencyPhone;
    public String FiduciaryNameFirst;
    public String FiduciaryNameMiddle;
    public String FiduciaryNameLast;
    public String FiduciaryContactRelationship;
    public String FiduciaryPhone;
    public String CauseOfDeathOnDeathCertificate;
    public String EmergencyLivingWithFirstName;
    public String EmergencyLivingWithMiddleName;
    public String EmergencyLivingWithLastName;
    public String EmergencyLivingWithRelationship;
    public String EmergLivingWithPhoneNumber;
    public String EmergencyNotLivingWithFirstName;
    public String EmergencyNotLivingWithMiddleName;
    public String EmergencyNotLivingWithLastName;
    public String EmergNotLivingWithPhoneNumber;
    public String EmergencyNotLivingWithRelation;
    public String AlternateEmail;
    public String AlternatePhone;
    public String PreferredMethodOfCommunication;
    public String BestTimeToReach;
    public String LegalAuthority;
    public String USResident;
    public String StatusOnBase;
    public String InjuredPartyJobEmployeer;
    public String MilitaryBranch;
    public String ExposureTimelineVerification;
    public String EmbryoExposureFrequency;
    public String ResideOrWorkCLJ;
    public String RelevantParty1FirstName;
    public String RelevantParty1MiddleName;
    public String RelevantParty1LastName;
    public String ExposureVerification;
    public String ExposureAddress;
    public String ExposureRecords;
    public String MiscarriageDates;
    public String DxDoctors;
    public String AllTreatmentFacilityAddresses;
    public String PharmaciesUsed;
    public String ExposureProofDocuments;
    public String ReceivedBenefits;
    public String EmergencyContactRelation;
    public String LegalConfirmationOfRep;
    public String WhereOnBase;
    public String BestCallBack;
    public String ExposureFrequency;
    public String DxProviders;
    
    public List<AilmentData> plAilmentDataList = new List<AilmentData>();
    
    public EvergreenModelCMPL(Camp_Lejeune__c cmplObject) {
        //TimeZone
        super(cmplObject.Lead__r);
        MassTortName = 'Camp Lejeune';

		InjuredPartyMaritalStatus = cmplObject.Marital_Status__c;
		//ContactingConsent = cmplObject.Lead__r.Contacting_Consent__c;
        
        // Personal Information
        if (cmplObject.Other_Name__c != null) {
            List<String> fullNameSplitted = cmplObject.Other_Name__c.split(' ');
			
            InjuredPartyFirstName = fullNameSplitted.get(0);
            InjuredPartyLastName = fullNameSplitted.get(fullNameSplitted.size()-1);
            if (fullNameSplitted.size() == 3){
            	InjuredPartyMiddleName = fullNameSplitted.get(1);
            }
            //InjuredPartyFirstName = cmplObject.Other_Name__c?.contains(' ') ? cmplObject.Other_Name__c?.split(' ')[0] : cmplObject.Other_Name__c;
        	//InjuredPartyLastName = cmplObject.Other_Name__c?.contains(' ') ? cmplObject.Other_Name__c?.split(' ')[1] : cmplObject.Other_Name__c;
        }
        
        RelationshipToInjuredParty = cmplObject.Relation_with_Client__c;
        if (cmplObject.Caller_Has_Authority_to_Sign__c == 'Executor of estate') {
            LegalAuthority = 'Executor/Administrator of Estate';
        } else if (cmplObject.Caller_Has_Authority_to_Sign__c == 'POA') {
            LegalAuthority = 'Attorney-in-Fact (Power of Attorney)';
        } else if (cmplObject.Caller_Has_Authority_to_Sign__c == 'NOK') {
            LegalAuthority = 'Next of Kin';
        } else if (cmplObject.Caller_Has_Authority_to_Sign__c == 'Spouse') {
            LegalAuthority = 'Other';
        } else if (cmplObject.Caller_Has_Authority_to_Sign__c == 'Guardianship') {
            LegalAuthority = 'Legal Gauridian';
        } else {
            LegalAuthority = cmplObject.Caller_Has_Authority_to_Sign__c;
        }
        InjuredPartyDateofBirth = cmplObject.Client_Date_Of_Birth__c;
        Lovedonealiveordeceased = cmplObject.Is_Person_Deceased__c == 'Yes' ? 'Deceased' : 'Alive';
        InjuredPartyDateofDeath = cmplObject.Date_Of_Passing__c;
        CauseOfDeathOnDeathCertificate = cmplObject.Cause_Of_Death__c;
        InjuredPartySSN = cmplObject.SSN__c;
        AlternateEmail = cmplObject.Secondary_Email__c;
        AlternatePhone = cmplObject.Alternate_Phone__c;
        PreferredMethodOfCommunication = cmplObject.Preferred_Communication_Methods__c;
        BestTimeToReach = cmplObject.Best_Time_to_Reach__c;
        
        // Emergency Contact Information
        if (cmplObject.Emergency_Contact_Name__c != null) {
            List<String> fullNameSplitted = cmplObject.Emergency_Contact_Name__c.split(' ');
			
            AuthorizedEmergencyContactFirst = fullNameSplitted.get(0);
            AuthorizedEmergencyContactLast = fullNameSplitted.get(fullNameSplitted.size()-1);
            if (fullNameSplitted.size() == 3){
            	AuthorizedEmergencyContactMiddle = fullNameSplitted.get(1);
            }
            
            //AuthorizedEmergencyContactFirst = cmplObject.Emergency_Contact_Name__c?.contains(' ') ? cmplObject.Emergency_Contact_Name__c?.split(' ')[0] : cmplObject.Emergency_Contact_Name__c;
            //AuthorizedEmergencyContactMiddle = cmplObject.Emergency_Contact_Name__c;
            //AuthorizedEmergencyContactLast = cmplObject.Emergency_Contact_Name__c?.contains(' ') ? cmplObject.Emergency_Contact_Name__c?.split(' ')[1] : cmplObject.Emergency_Contact_Name__c;
        }
        EmergencyPhone = cmplObject.Emergency_Contact_Phone__c;
        
        // Fiduciary Information
        if (cmplObject.Fiduciary_Name__c != null) {          
            List<String> fullNameSplitted = cmplObject.Fiduciary_Name__c.split(' ');
			
            FiduciaryNameFirst = fullNameSplitted.get(0);
            FiduciaryNameLast = fullNameSplitted.get(fullNameSplitted.size()-1);
            if (fullNameSplitted.size() == 3){
            	FiduciaryNameMiddle = fullNameSplitted.get(1);
            }    
        }
        FiduciaryContactRelationship = cmplObject.Fiduciary_Contact_Relationship__c;
        FiduciaryPhone = cmplObject.Fiduciary_Phone__c;
        
        // Emergency Living With Information
        if (cmplObject.Co_Living_Emergency_Contact_Name__c != null) {
            List<String> fullNameSplitted = cmplObject.Co_Living_Emergency_Contact_Name__c.split(' ');
			
            EmergencyLivingWithFirstName = fullNameSplitted.get(0);
            EmergencyLivingWithLastName = fullNameSplitted.get(fullNameSplitted.size()-1);
            if (fullNameSplitted.size() == 3){
            	EmergencyLivingWithMiddleName = fullNameSplitted.get(1);
            }    
        }
        EmergLivingWithPhoneNumber = cmplObject.Co_Living_Emergency_Contact_Phone__c;
        EmergencyLivingWithRelationship = cmplObject.Co_Living_Emergency_Contact_Relationship__c;
        
        // Emergency Not Living With Information
        if (cmplObject.Non_Co_Living_Emergency_Contact_Name__c != null) {
            List<String> fullNameSplitted = cmplObject.Non_Co_Living_Emergency_Contact_Name__c.split(' ');
			
            EmergencyNotLivingWithFirstName = fullNameSplitted.get(0);
            EmergencyNotLivingWithLastName = fullNameSplitted.get(fullNameSplitted.size()-1);
            if (fullNameSplitted.size() == 3){
            	EmergencyNotLivingWithMiddleName = fullNameSplitted.get(1);
            }    
        }
            
        EmergNotLivingWithPhoneNumber = cmplObject.Non_Co_Living_Emergency_Contact_Phone__c;
        EmergencyNotLivingWithRelation = cmplObject.Non_Co_Living_Emergency_Contact_Relation__c;
        
        // General Information
        SoughtCompensationAlready = cmplObject.Currently_Represented_by_Attorney__c;
        USResident = cmplObject.Resident_of_the_United_States__c;
        StatusOnBase = cmplObject.Injured_Party_Affiliation__c;
        InjuredPartyJobEmployeer = cmplObject.Presence_at_Camp_Lejeune_Details__c;
        MilitaryBranch = cmplObject.Military_Details__c;
        ExposureTimelineVerification = cmplObject.Camp_Lejeune_Residence_Work_History__c;
        EmbryoExposureFrequency = cmplObject.In_Utero_At_Camp_Lejeune__c;
        ExposureStartDate = cmplObject.First_Exposure_Date__c;
        ExposureEndDate = cmplObject.Last_Exposure_Date__c;
        ResideOrWorkCLJ = cmplObject.Worked_or_Resided_at_Camp_Lejeune__c;
        MiscarriageDates = cmplObject.Miscarriages_Fertility_Pregnancy_Issues__c;
        //DxDoctors = cmplObject.
        AllTreatmentFacilityAddresses = cmplObject.Pharmacy_Information__c;
        PharmaciesUsed = cmplObject.Have_Camp_Lejeune_Documents__c;
        
        // Relevant Party Information
        if (cmplObject.Military_Family_Member_Full_Name__c != null) {
            List<String> fullNameSplitted = cmplObject.Military_Family_Member_Full_Name__c.split(' ');
			
            RelevantParty1FirstName = fullNameSplitted.get(0);
            RelevantParty1LastName = fullNameSplitted.get(fullNameSplitted.size()-1);
            if (fullNameSplitted.size() == 3){
            	RelevantParty1MiddleName = fullNameSplitted.get(1);
            }    
        }
        
        // Exposure Information
        ExposureVerification = cmplObject.Exposure_To_Contaminated_Water__c;
        ExposureAddress = cmplObject.Location_At_Camp_Lejeune__c;
        ExposureRecords = cmplObject.Records_to_Substantiate_Camp_Time__c;
        ExposureProofDocuments = cmplObject.Have_Camp_Lejeune_Documents__c;
        ReceivedBenefits = cmplObject.Received_Benefits__c;
        EmergencyContactRelation = cmplObject.Emergency_Contact_Relation__c;
        LegalConfirmationOfRep = cmplObject.Affirmation_of_Exclusive_Representation__c;
        WhereOnBase = cmplObject.Location_At_Camp_Lejeune__c;
        BestCallBack = cmplObject.Lead__r.Phone;
        ExposureFrequency = cmplObject.In_Utero_At_Camp_Lejeune__c;
        DxProviders = cmplObject.Doctors_and_Specialties__c;
            
        List<String> selectedAilmentsTier1 = cmplObject.Tier_1_Diagnoses__c?.split(';');
        if(selectedAilmentsTier1 != null && !selectedAilmentsTier1.isEmpty()) {
            for (String ailment : selectedAilmentsTier1) {
                AilmentData ailmentData = new AilmentData(); // Initialize AilmentData
                ailmentData.Ailment = ailment.trim();
                if(ailmentData.Ailment == 'Kidney cancer') {
                    ailmentData.DateOfDiagnosis = cmplObject.Kidney_Cancer_Diagnosis_Date__c;
                } else if(ailmentData.Ailment.contains('Kidney disease')) {
                    ailmentData.DateOfDiagnosis = cmplObject.Kidney_Disease_Diagnosis_Date__c;
                } else if(ailmentData.Ailment.contains('Leukemia')) {
                    ailmentData.DateOfDiagnosis = cmplObject.Leukemia_Diagnosis_Date__c;   
                } else if(ailmentData.Ailment == 'Liver cancer') {
                    ailmentData.DateOfDiagnosis = cmplObject.Liver_Cancer_Diagnosis_Date__c;
                } else if(ailmentData.Ailment == 'Multiple myeloma and myelodysplastic Syndromes') {
                    ailmentData.DateOfDiagnosis = cmplObject.Multiple_Myeloma_Diagnosis_Date__c;
                } else if(ailmentData.Ailment == 'Non-Hodgkin lymphoma') {
                    ailmentData.DateOfDiagnosis = cmplObject.Non_Hodgkin_Lymphoma_Diagnosis_Date__c;
                } else if(ailmentData.Ailment.contains('Parkinson')) {
                    ailmentData.DateOfDiagnosis = cmplObject.Parkinson_s_Disease_Diagnosis_Date__c;
                } else if(ailmentData.Ailment == 'Systemic sclerosis') {
                    ailmentData.DateOfDiagnosis = cmplObject.Systemic_Sclerosis_Diagnosis_Date__c;
                }
                plAilmentDataList.add(ailmentData);
            }
        }
        
        List<String> selectedAilmentsTier2 = cmplObject.Tier_2_Diagnoses__c?.split(';');
        if(selectedAilmentsTier2 != null && !selectedAilmentsTier2.isEmpty()) {
            for (String ailment : selectedAilmentsTier2) {
                AilmentData ailmentData = new AilmentData(); // Initialize AilmentData
                ailmentData.Ailment = ailment.trim();
                if(ailmentData.Ailment == 'Esophageal cancer') {
                    ailmentData.DateOfDiagnosis = cmplObject.Esophageal_Cancer_Diagnosis_Date__c;
                } else if(ailmentData.Ailment == 'Lung cancer') {
                    ailmentData.DateOfDiagnosis = cmplObject.Lung_Cancer_Diagnosis_Date__c;
                } else if(ailmentData.Ailment == 'Breast Cancer (Male)') {
                    ailmentData.DateOfDiagnosis = cmplObject.Breast_Cancer_Male_Diagnosis_Date__c;   
                } else if(ailmentData.Ailment == 'Miscarriage / Fetal Death') {
                    ailmentData.DateOfDiagnosis = cmplObject.Miscarriage_Fetal_Death_Diagnosis_Date__c;
                } else if(ailmentData.Ailment == 'Congenital Cardiac Defect') {
                    ailmentData.DateOfDiagnosis = cmplObject.Congenital_Cardiac_Defect_Diagnosis_Date__c;
                } else if(ailmentData.Ailment.contains('Other Serious Birth Defects')) {
                    ailmentData.DateOfDiagnosis = cmplObject.Other_Serious_Birth_Defects_Diagnosis_Da__c;
                }
                plAilmentDataList.add(ailmentData);
            }
        }
        
        List<String> selectedAilmentsTier3 = cmplObject.Tier_3_Diagnoses__c?.split(';');
        if(selectedAilmentsTier3 != null && !selectedAilmentsTier3.isEmpty()) {
            for (String ailment : selectedAilmentsTier3) {
                AilmentData ailmentData = new AilmentData(); 
                ailmentData.Ailment = ailment.trim();
                if(ailmentData.Ailment == 'Aplastic Anemia') {
                    ailmentData.DateOfDiagnosis = cmplObject.Aplastic_Anemia_Diagnosis_Date__c;
                } else if(ailmentData.Ailment == 'Brain cancer') {
                    ailmentData.DateOfDiagnosis = cmplObject.Brain_Cancer_Diagnosis_Date__c;
                } else if(ailmentData.Ailment == 'Cervical cancer') {
                    ailmentData.DateOfDiagnosis = cmplObject.Cervical_Cancer_Diagnosis_Date__c;   
                } else if(ailmentData.Ailment == 'Prostate cancer') {
                    ailmentData.DateOfDiagnosis = cmplObject.Prostate_Cancer_Diagnosis_Date__c;
                } else if(ailmentData.Ailment == 'Ovarian cancer') {
                    ailmentData.DateOfDiagnosis = cmplObject.Ovarian_Cancer_Diagnosis_Date__c;
                } else if(ailmentData.Ailment.contains('Liver Disease')) {
                    ailmentData.DateOfDiagnosis = cmplObject.Liver_Disease_Diagnosis_Date__c;
                } else if(ailmentData.Ailment.contains('Hodgkins Disease')) {
                    ailmentData.DateOfDiagnosis = cmplObject.Hodgkin_s_Disease_Diagnosis_Date__c;
                } else if(ailmentData.Ailment == 'Rectal Cancer') {
                    ailmentData.DateOfDiagnosis = cmplObject.Rectal_Cancer_Diagnosis_Date__c;
                } else if(ailmentData.Ailment == 'Soft Tissue Cancer / Sarcoma') {
                    ailmentData.DateOfDiagnosis = cmplObject.Soft_Tissue_Cancer_Diagnosis_Date__c;
                }
                plAilmentDataList.add(ailmentData);
            }
        }
        
		List<String> selectedAilmentsTier4 = cmplObject.Tier_4_Diagnoses__c?.split(';');
        if(selectedAilmentsTier4 != null && !selectedAilmentsTier4.isEmpty()) {
            for (String ailment : selectedAilmentsTier4) {
                AilmentData ailmentData = new AilmentData(); 
                ailmentData.Ailment = ailment.trim();
                if(ailmentData.Ailment == 'Neurobehavioral effects') {
                    ailmentData.DateOfDiagnosis = cmplObject.Neurobehavioral_Effects_Diagnosis_Date__c;
                } else if(ailmentData.Ailment == 'ALS') {
                    ailmentData.DateOfDiagnosis = cmplObject.ALS_Diagnosis_Date__c;
                } else if(ailmentData.Ailment == 'Bile Duct Cancer') {
                    ailmentData.DateOfDiagnosis = cmplObject.Bile_Duct_Cancer_Diagnosis_Date__c;   
                } else if(ailmentData.Ailment.contains('Colon Cancer')) {
                    ailmentData.DateOfDiagnosis = cmplObject.Colon_Cancer_Diagnosis_Date__c;
                } else if(ailmentData.Ailment == 'Laryngeal Cancer') {
                    ailmentData.DateOfDiagnosis = cmplObject.Laryngeal_Cancer_Diagnosis_Date__c;
                } else if(ailmentData.Ailment == 'Oral Cancer') {
                    ailmentData.DateOfDiagnosis = cmplObject.Oral_Cancer_Diagnosis_Date__c;
                } else if(ailmentData.Ailment == 'Pharyngeal Cancer') {
                    ailmentData.DateOfDiagnosis = cmplObject.Pharyngeal_Cancer_Diagnosis_Date__c;
                } else if(ailmentData.Ailment == 'Pancreatic Cancer') {
                    ailmentData.DateOfDiagnosis = cmplObject.Pancreatic_Cancer_Diagnosis_Date__c;
                } else if(ailmentData.Ailment == 'Thyroid Cancer') {
                    ailmentData.DateOfDiagnosis = cmplObject.Thyroid_Cancer_Diagnosis_Date__c;
                } else if(ailmentData.Ailment == 'Autoimmune Disease') {
                    ailmentData.DateOfDiagnosis = cmplObject.Autoimmune_Disease_Diagnosis_Date__c;
                }
                plAilmentDataList.add(ailmentData);
            }
        }
        
        List<String> selectedAilmentsTier5 = cmplObject.Tier_5_Diagnoses__c?.split(';');
        if(selectedAilmentsTier5 != null && !selectedAilmentsTier5.isEmpty()) {
            for (String ailment : selectedAilmentsTier5) {
                AilmentData ailmentData = new AilmentData(); 
                ailmentData.Ailment = ailment.trim();
                if(ailmentData.Ailment.contains('Neurological effects')) {
                    ailmentData.DateOfDiagnosis = cmplObject.Neurological_Effects_Diagnosis_Date__c;
                } else if(ailmentData.Ailment.contains('Neurobehavioral performance deficits')) {
                    ailmentData.DateOfDiagnosis = cmplObject.Neurobehavioral_Deficits_Diagnosis_Date__c;
                } else if(ailmentData.Ailment == 'Infertility (Male or Female)') {
                    ailmentData.DateOfDiagnosis = cmplObject.Infertility_Diagnosis_Date__c;   
                } else if(ailmentData.Ailment.contains('Low sperm count')) {
                    ailmentData.DateOfDiagnosis = cmplObject.Low_Sperm_Count_Diagnosis_Date__c;
                } else if(ailmentData.Ailment == 'Hypersensitivity Skin Disorder') {
                    ailmentData.DateOfDiagnosis = cmplObject.Hypersensitivity_Skin_Diagnosis_Date__c;
                } else if(ailmentData.Ailment == 'Lupus') {
                    ailmentData.DateOfDiagnosis = cmplObject.Lupus_Diagnosis_Date__c;
                } else if(ailmentData.Ailment == 'Multiple sclerosis') {
                    ailmentData.DateOfDiagnosis = cmplObject.Multiple_Sclerosis_Diagnosis_Date__c;
                }
                plAilmentDataList.add(ailmentData);
            }
        }
    }
}