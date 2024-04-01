public class EvergreenModelTalc extends EvergreenModel{
	// Fields specific to Talc__c
    public String NextofKinorLegalRep;
    public String LegalAuthority;
    public String PreviouslyUsedNameFirst;
    public String PreviouslyUsedNameLast;
    public String LegalConfirmationOfRep;
    public String SpouseFirstName;
	public String SpouseLastName;
	public String SpouseMiddleName;
    //public String CauseOfDeathOnDeathCertificate;
    public String AlternateEmail;
    public String AlternatePhone;
    //public String InjuredPartyPhone;
    public String PreferredMethodOfCommunication;
    public String BestTimeToReach;
    //public String ContactingConsent;
    public String WantsDisengagedFromPrevRep;
    public String HaveYouBeenFormallyReleased;
    public String WhyHaveYouBeenReleased;
    public String UsedJJBP;
    public String UsedJJSS;
    public String ProviderInformedPotentialCause;
    public String OtherExposure;
    public String FirstLearnAboutTort;
    public String OtherCancerDx;
    public String OTCProviderPrefix;
    public String OTCProviderFirstName;
    public String OTCProviderMiddleName;
    public String OTCProviderLastName;
    public String TestedForBRCAMutation;
    public String DxWithObesityClinicallyOverweight;
    public String FamHistoryOfOvarianBreastCancer;
    public String RelativesWithGeneticMutations;
    public String ProviderCountLast10Years;
    public Date LastYearOfProviderVisit;
    public String CancerRelatedProviderCount;
    public String PreCancerProviderCountLast10Yrs;
    public String PharmaciesUsedCountLast10Years;
    public String CurrentlySmoke;
    public String SmokedCigarettes;
    public String PersonallyFiledSuitOvarianCancer;
    public String FiledSuitImerysBankruptcy;
    public String OvariesRemoved;
    public String FallopianTubesRemoved;
    public String PrevRepDoYouWantToBeReleased;
    public String InjuredPartyGender;
    public String LegalAuthorityVerified;
    public String TubalLigation;
    public String ExposedLocation;
    public String MassTortName;
    
    public List<AilmentData> plAilmentDataList = new List<AilmentData>();

    public EvergreenModelTalc(Talc__c talcObject) {
        super(talcObject.Lead__r);
        MassTortName = 'Talc';
        
        // Map fields specific to Talc__c
        if (talcObject.Injureds_Full_Legal_Name__c != null){
            InjuredPartyFirstName = talcObject.Injureds_Full_Legal_Name__c?.contains(' ') ? talcObject.Injureds_Full_Legal_Name__c?.split(' ')[0] : talcObject.Injureds_Full_Legal_Name__c;
        	//InjuredPartyMiddleName = talcObject.Injureds_Full_Legal_Name__c;
			InjuredPartyLastName = talcObject.Injureds_Full_Legal_Name__c?.contains(' ') ? talcObject.Injureds_Full_Legal_Name__c?.split(' ')[1] : talcObject.Injureds_Full_Legal_Name__c;
        }
		LegalConfirmationOfRep = talcObject.Previously_represented_by_Attorney__c == true ? 'Yes' : 'No';
		Lovedonealiveordeceased =  talcObject.Is_Injured_deceased__c == 'Yes' ? 'Deceased' : 'Alive';
		InjuredPartyDateofDeath = talcObject.Injureds_date_of_death__c;
		InjuredPartyDateofBirth = talcObject.Injureds_Date_of_Birth__c;
		InjuredPartyMaritalStatus = talcObject.Marital_Status__c;
		AlternatePhone = talcObject.Alternate_Phone_Number__c;
        NextofKinorLegalRep = talcObject.Next_Of_Kin__c;
        ExposureStartDate = talcObject.Monthyear_started_using_product__c;
        PreviouslyUsedNameFirst = talcObject.Maiden_Other_Names_Used__c;
        PreviouslyUsedNameLast = talcObject.Maiden_Other_Names_Used__c;
        InjuredPartySSN = talcObject.SSN__C;
        if(talcObject.Spouse_s_Name__c != null){
        	SpouseFirstName = talcObject.Spouse_s_Name__c?.contains(' ') ? talcObject.Spouse_s_Name__c?.split(' ')[0] : talcObject.Spouse_s_Name__c;
        	SpouseLastName = talcObject.Spouse_s_Name__c?.contains(' ') ? talcObject.Spouse_s_Name__c?.split(' ')[1] : talcObject.Spouse_s_Name__c;
        }
        WantsDisengagedFromPrevRep = talcObject.Lawyer_Name_and_Contact_Information__c;
        HaveYouBeenFormallyReleased = talcObject.Formally_Released__c;
        WhyHaveYouBeenReleased = talcObject.Reason_for_Release__c;
        PrevRepDoYouWantToBeReleased = talcObject.Release_Preference__c;
        UsedJJBP = talcObject.Used_Johnson_Johnson_Powder__c;
        UsedJJSS = talcObject.Used_Johnson_Johnson_Shower__c;
        CancerRelatedProviderCount = talcObject.Number_of_Unidentified_Cancer_Providers__c;
        PreCancerProviderCountLast10Yrs = talcObject.Number_of_Pre_cancer_Providers_Visited__c;
        ProviderCountLast10Years = talcObject.Number_of_Providers__c;
        LastYearOfProviderVisit = talcObject.Last_Visit_Year_PC_Prov_5__c;
        PharmaciesUsedCountLast10Years = talcObject.Number_of_Pharmacies_Used__c;
        CurrentlySmoke = talcObject.Currently_Smoke_Cigarettes__c;
		SmokedCigarettes = talcObject.Past_Smoked_Cigarettes__c;
		PersonallyFiledSuitOvarianCancer = talcObject.Filed_Lawsuit_for_Ovarian_Cancer__c;
		FiledSuitImerysBankruptcy = talcObject.Filed_Claim_in_Imerys_Bankruptcy__c;
        BestTimeToReach = talcObject.Best_Time_to_Reach__c;
		OvariesRemoved = talcObject.Ovaries_Removed_During_Surgery__c;
		FallopianTubesRemoved = talcObject.Fallopian_Tubes_Removed_During_Surgery__c;       
        InjuredPartyGender = talcObject.Injureds_Gender__c;
        LegalAuthorityVerified = talcObject.Legal_authority_to_represent_Injured__c;
        LegalAuthority = talcObject.Name_of_the_legal_authority__c;
        TubalLigation = talcObject.Had_a_Tubal_Ligation__c;          
        RelationshipToInjuredParty = talcObject.Your_relation_to_the_injured__c;
        FamHistoryOfOvarianBreastCancer = talcObject.Family_History_Ovarian_Breast_Cancer__c;
        RelativesWithGeneticMutations = talcObject.Family_History_Genetic_Mutations__c;
        SoughtCompensationAlready = talcObject.Represented_By_Law_Firm__c;
		ExposedLocation = talcObject.Where_did_you_apply_product__c;
		//ProviderInformedPotentialCause = 
		OtherExposure = talcObject.Used_Other_Cosmetic_Powder_Products__c;
		ExposureEndDate = talcObject.Monthyear_stopped_using_product__c;
		FirstLearnAboutTort = talcObject.Time_of_Connection_Awareness__c;
		TestedForBRCAMutation = talcObject.Tested_for_the_BRCA1_or_BRCA2_mutation__c;
		OtherCancerDx = talcObject.Diagnosed_with_Other_Cancer__c;
		//OTCProviderPrefix = 
		OTCProviderFirstName = talcObject.Diagnosing_Doctor__c;
		//OTCProviderMiddleName = 
		OTCProviderLastName = talcObject.Diagnosing_Doctor__c;
		DxWithObesityClinicallyOverweight = talcObject.Diagnosed_with_Obesity_Overweight__c;
        //TimeZone = talcObject.Time_Zone__c;

        List<String> selectedAilments = talcObject?.Injury_diagnosed_with__c?.split(';');
        if(selectedAilments != null && !selectedAilments.isEmpty()) {
            for (String ailment : selectedAilments) {
                AilmentData ailmentData = new AilmentData(); // Initialize AilmentData
                ailmentData.Ailment = ailment.trim();
                if(ailmentData.Ailment == 'Mesothelioma') {
                    ailmentData.DateOfDiagnosis = talcObject.First_diagnosed_mesothelioma__c;
                } else if(ailmentData.Ailment == 'Primary Peritoneal') {
                    ailmentData.DateOfDiagnosis = talcObject.First_diagnosed_primary_peritoneal__c;
                    ailmentData.AilmentTypeSpecific = talcObject.Cancer_Type_at_Dx__c;
                    ailmentData.AilmentStage = talcObject.Cancer_Stage_at_Dx__c;
                } else if(ailmentData.Ailment == 'Fallopian Tube Cancer') {
                    ailmentData.DateOfDiagnosis = talcObject.First_diagnosed_fallopian_tube__c;
                    ailmentData.AilmentTypeSpecific = talcObject.Cancer_Type_at_Dx__c;
                    ailmentData.AilmentStage = talcObject.Cancer_Stage_at_Dx__c;    
                } else if(ailmentData.Ailment == 'Ovarian Cancer') {
                    ailmentData.DateOfDiagnosis = talcObject.First_diagnosed_ovarian_cancer__c;
                    ailmentData.AilmentTypeSpecific = talcObject.Cancer_Type_at_Dx__c;
                    ailmentData.AilmentStage = talcObject.Cancer_Stage_at_Dx__c;
                } else if(ailmentData.Ailment == 'Cervical Cancer') {
                    ailmentData.DateOfDiagnosis = talcObject.First_diagnosed_cervical_cancer__c;
                } else if(ailmentData.Ailment == 'Uterine Cancer') {
                    ailmentData.DateOfDiagnosis = talcObject.First_diagnosed_uterine_cancer__c;
                } else if(ailmentData.Ailment == 'Vaginal Cancer') {
                    ailmentData.DateOfDiagnosis = talcObject.First_diagnosed_vaginal_cancer__c;
                } else if(ailmentData.Ailment == 'Vulvar Cancer') {
                    //ailmentData.DateOfDiagnosis = talcObject.First_diagnosed_vulvar_cancer__c;
                } else if(ailmentData.Ailment == 'Endometrial cancer') {
                    ailmentData.DateOfDiagnosis = talcObject.First_diagnosed_endometerial_cancer__c;
                }
                plAilmentDataList.add(ailmentData);
            }
        }
    }
        
    public class AilmentData {
        public Date DateOfDiagnosis;
        public String Ailment;
        public String AilmentTypeSpecific;
        public String AilmentStage;
	}
}