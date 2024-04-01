public class TestDataFactory {
    
	public static Lead createTestLead() {
        Lead testLead = new Lead(
            FirstName = 'Test',
            LastName = 'Lead',
            City = 'TestCity',
            State = 'Alabama',
            Street = 'TestStreet',
            PostalCode = '12345',
            Phone = '123-456-7890',
            Email = 'test@example.com',
            Status = 'Qualified',
            Calling_for_yourself__c = 'Self',
            Signature_Mail_Request__c = 'Digital',
            Caller_Recorded_Consent__c = 'Yes',
            Contacting_Consent__c = 'Yes',
            Additional_Notes__c = 'Test notes'
        );
        insert testLead;
        return testLead;
    }

    public static Talc__c createTestTalc(Lead testLead) {
        //Lead testLead = createTestLead();
        Talc__c testTalc = new Talc__c(
            Lead__r = testLead,
            Lead__c = testLead.Id,
            Next_Of_Kin__c = 'Test Next of Kin',
            Injureds_Full_Legal_Name__c = 'Emina Test',
            Spouse_s_Name__c = 'Spouse Test',
            Any_other_significant_exposure__c = 'Test exposure',
            Injury_diagnosed_with__c = 'Mesothelioma;Primary Peritoneal;Fallopian Tube Cancer;Ovarian Cancer;Cervical Cancer;Uterine Cancer;Vaginal Cancer;Endometrial cancer'
        );
        insert testTalc;
        return testTalc;
    }

	public static Camp_Lejeune__c createTestCMPL(Lead testLead) {
        //Lead testLead = createTestLead();
        Camp_Lejeune__c testCMPL = new Camp_Lejeune__c(
            Lead__r = testLead,
            Lead__c = testLead.Id,
            Next_Of_Kin__c = 'Test Next of Kin',
            Other_Name__c = 'Emina Test',
            Caller_Has_Authority_to_Sign__c = 'POA',
            SSN__c = '123-444-5556',
            Tier_1_Diagnoses__c = 'Kidney cancer;Leukemia;Liver cancer;Parkinson;Systemic sclerosis;Non-Hodgkin lymphoma;Multiple myeloma and myelodysplastic Syndromes',
            Tier_2_Diagnoses__c = 'Esophageal cancer;Lung cancer;Miscarriage / Fetal Death;Congenital Cardiac Defect',
            Tier_3_Diagnoses__c = 'Aplastic Anemia;Brain cancer;Cervical cancer;Prostate cancer;Ovarian cancer;Liver Disease;Hodgkins Disease;Rectal Cancer;Soft Tissue Cancer / Sarcoma',
            Tier_4_Diagnoses__c = 'Neurobehavioral effects;ALS;Bile Duct Cancer;Colon Cancer;Laryngeal Cancer;Oral Cancer;Pharyngeal Cancer;Pancreatic Cancer;Thyroid Cancer;Autoimmune Disease',
            Tier_5_Diagnoses__c = 'Neurological effects;Neurobehavioral performance deficits;Infertility (Male or Female);Hypersensitivity Skin Disorder;Lupus;Multiple sclerosis'
            // Add other required fields here
        );
        insert testCMPL;
        return testCMPL;
    }
    
    public static Tylenol__c createTestTylenol(Lead testLead) {
        //Lead testLead = createTestLead();
        Tylenol__c testTyl = new Tylenol__c(
            Lead__r = testLead,
            Lead__c = testLead.Id,
            Accurate_Information_Agreement__c = 'Yes',
            Client_Name__c = 'Emina Test',
            Gender__c = 'Female',
            Child_s_SSN__c = '123-444-5556',
            Father_s_Age_at_Baby_s_Birth__c = '34'
            // Add other required fields here
        );
        insert testTyl;
        return testTyl;
    }
    
    public static ContentDocumentLink createTestContentDocument(Lead testLead) {
        //Lead testLead = createTestLead();
		ContentVersion testContentVersion = new ContentVersion(
            Title = 'Test Attachment.pdf',
            VersionData = Blob.valueOf('Test attachment content'),
            PathOnClient = 'Test Attachment.pdf'
        );
        insert testContentVersion;
        
        // Create a ContentDocumentLink record
        ContentDocumentLink testAttachmentLink = new ContentDocumentLink(
            ContentDocumentId = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id = :testContentVersion.Id].ContentDocumentId,
            LinkedEntityId = testLead.Id,
            ShareType = 'V'
        );
		insert testAttachmentLink;
        return testAttachmentLink;
    }
}