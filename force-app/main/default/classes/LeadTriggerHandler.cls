public with sharing class LeadTriggerHandler {

    // Configuration values for the SmarAdvocate Integration - Marriot
    private static final String LEAD_DATA_ENDPOINT = 'https://hl.smartadvocate.com/SAService/sawebservice.svc/Receiver/OfficeCalls/2f6605127f3146238c56ac064f2e2575';
    private static final String API_KEY = '2f6605127f3146238c56ac064f2e2575';
    private static final String DOCUMENT_UPLOAD_ENDPOINT = 'https://hl.smartadvocate.com/SAService/sawebservice.svc/Receiver/uploaddocument';

    public static void sendRetainerOnStatusUpdate(Id recordId) {
        List <Lead> leadRec = [SELECT Id, Email, Name, Company__c, Campaign__c, Campaign__r.Name, Retainer_to_Send__c FROM Lead WHERE Id = :recordId AND Company__r.Name = 'Saddle Rock' AND (Campaign__r.Name = 'NEC' OR Campaign__r.Name = 'Roundup') WITH SECURITY_ENFORCED];

        if(leadRec != null && !leadRec.isEmpty() && leadRec[0]?.Campaign__r?.Name == 'NEC') {
            if (leadRec[0].Retainer_to_Send__c == 'TH: Child DOB 2002-2005 & lives in any state (Child filling for themselves who is an adult)') {
                SendSignatureRequestWithTemplate.generateHelloSignature(leadRec[0].Email, leadRec[0].Name, leadRec[0].Id, 'SR NEC - TH - adult child self - any state (2002-2005)');
            } else if (leadRec[0].Retainer_to_Send__c == 'KP: Child DOB 2006-Present & lives in any state (Parent Filling for Child who is minor)') {
                SendSignatureRequestWithTemplate.generateHelloSignature(leadRec[0].Email, leadRec[0].Name, leadRec[0].Id, 'SR NEC - KP - parent filing obo minor - lives in any state');
            } else if (leadRec[0].Retainer_to_Send__c == 'KP: Child DOB 2006-Present & lives in any state (Child filling for themselves who is an adult)') {
                SendSignatureRequestWithTemplate.generateHelloSignature(leadRec[0].Email, leadRec[0].Name, leadRec[0].Id, 'SR NEC - KP - adult child self - lives in any state');
            } else if (leadRec[0].Retainer_to_Send__c == 'KP: Child DOB 2006-Present & lives in any state (Parent filling in addition to adult child) - *Adult child must also sign, if this is the case please fill out an intake for both'){
                SendSignatureRequestWithTemplate.generateHelloSignature(leadRec[0].Email, leadRec[0].Name, leadRec[0].Id, 'SR NEC - KP - parent obo self - lives in any state (Adult child must also sign)');
            } else if (leadRec[0].Retainer_to_Send__c == 'KKP: Child DOB 2006-Present & lives in Florida (Parent Filling for Child who is minor)') {
                SendSignatureRequestWithTemplate.generateHelloSignature(leadRec[0].Email, leadRec[0].Name, leadRec[0].Id, 'SR NEC - KP - parent filing obo minor - lives in FL');
            } else if (leadRec[0].Retainer_to_Send__c == 'KP: Child DOB 2006-Present & lives in Florida (Child filling for themselves who is an adult)') {
                SendSignatureRequestWithTemplate.generateHelloSignature(leadRec[0].Email, leadRec[0].Name, leadRec[0].Id, 'SR NEC - KP - adult child self - lives in FL');
            } else if (leadRec[0].Retainer_to_Send__c == 'KP: Child DOB 2006-Present & lives in Florida (Parent filling in addition to adult child) - *Adult child must also sign, if this is the case please fill out an intake for both'){
                SendSignatureRequestWithTemplate.generateHelloSignature(leadRec[0].Email, leadRec[0].Name, leadRec[0].Id, 'SR NEC - KP - parent obo self - lives in FL (Adult child must also sign)');
            } else if (leadRec[0].Retainer_to_Send__c == 'TH: Child DOB 2006-present & lives in MI or IL (Child filling for themselves who is an adult)'){
                SendSignatureRequestWithTemplate.generateHelloSignature(leadRec[0].Email, leadRec[0].Name, leadRec[0].Id, 'SR NEC - TH - adult child self - MI or IL');
            } else if (leadRec[0].Retainer_to_Send__c == 'TH: Child DOB 2006-present & lives in MI or IL (Parent Filling for Child who is minor)'){
                SendSignatureRequestWithTemplate.generateHelloSignature(leadRec[0].Email, leadRec[0].Name, leadRec[0].Id, 'SR NEC - TH - parent filing obo minor - MI or IL');
            } else {
                return;
            }
        } else if (leadRec != null && !leadRec.isEmpty() && leadRec[0]?.Campaign__r?.Name == 'Roundup') {
            if (leadRec[0].Retainer_to_Send__c == 'Kline Specter - Self - FL') {
                SendSignatureRequestWithTemplate.generateHelloSignature(leadRec[0].Email, leadRec[0].Name, leadRec[0].Id, 'Saddle Rock - Roundup - Self - FL');
            } else if (leadRec[0].Retainer_to_Send__c == 'Kline Specter - OBO - FL') {
                SendSignatureRequestWithTemplate.generateHelloSignature(leadRec[0].Email, leadRec[0].Name, leadRec[0].Id, 'Saddle Rock - Roundup - Loved one - FL');
            } else if (leadRec[0].Retainer_to_Send__c == 'Kline Specter - Self - any state') {
                SendSignatureRequestWithTemplate.generateHelloSignature(leadRec[0].Email, leadRec[0].Name, leadRec[0].Id, 'Saddle Rock - Roundup - Self - Any state');
            } else if (leadRec[0].Retainer_to_Send__c == 'Kline Specter - OBO - any state'){
                SendSignatureRequestWithTemplate.generateHelloSignature(leadRec[0].Email, leadRec[0].Name, leadRec[0].Id, 'Saddle Rock - Roundup - Loved one - Any state');
            } else {
                return;
            }
        }
    }

    public static void sendEventToMeta(Id recordId) {
        List <Lead> leadRec = [SELECT Id, Email, Name, Company__c, Campaign__c, Campaign__r.Name FROM Lead WHERE Id = :recordId];
        if (leadRec[0].Campaign__r.Name == 'Powerport') {
            System.enqueueJob(new FacebookCAPIQueueable(leadRec[0].Id));
        }
    }

    public static void scheduleSmartAdvocateIntegration(Id recordId) {
        List <Lead> leadList = [SELECT Id, FirstName, LastName, Email, Phone, Street, City, 
                State, PostalCode, Date_Signed__c, Additional_Notes__c, SSN__c, 
                Date_of_Birth__c, Company__r.Name, Gender__c, MobilePhone, Caller_Recorded_Consent__c, Contacting_Consent__c,
                    (SELECT Id, Spoken_to_Another_Attorney__c, Resided_in_CA_During_Booking__c, 
                        Used_Marriott_Website__c, Browser_Type_Used__c, Device_Type_Used__c, 
                        Have_Marriott_Bonvoy_Account__c, Privacy_Tools_Enabled__c, 
                        Facebook_Account_During_Booking__c, Logged_Into_Facebook_During_Booking__c, 
                        Logged_Into_Facebook_90_Days_Prior__c, Refused_to_Provide_SSN__c, Will_Provide_SSN__c,
                        Non_Mobile_Device_Setup__c 
                    FROM Case_Details__r),
                    (SELECT Id, United_States_Resident__c, Emergency_Contact_Name__c, Emergency_Contact_Phone__c, 
                        Have_Permission_to_Contact_Emergency__c, Have_Permission_to_Reference_Case__c, Lead__c, Date_of_Birth__c 
                    FROM Client_Information__r)
                FROM Lead
                WHERE Id = :recordId];

        List<Object> leadModels = SmartAdvocateModel.mapToSmartAdvocateMarriot(leadList);
    	String leadJson = JSON.serialize(leadModels[0]);

        // Introduce a delay before calling sendLeadDataAsync
        String year = String.valueOf(Datetime.now().year());
        String month = Datetime.now().format('MMM').toUpperCase();
        String day = String.valueOf(Datetime.now().day());
        String hour = String.valueOf(Datetime.now().hour());
		String min = String.valueOf(Datetime.now().minute() + 2);
		String ss = String.valueOf(Datetime.now().second());

        String nextFireTime = ss + ' ' + min + ' ' + hour + ' ' +  day + ' ' + month + ' ? ' + year;
        System.debug('nextFireTime ::: ' + nextFireTime);

        // Create the schedulable job
        try {
            System.schedule(
                'scheduleSmartAdvocateIntegration_' + recordId + System.now(),
                nextFireTime,
                new SmartAdvocateSchedule(
                    leadJson,
                    recordId,
                    LEAD_DATA_ENDPOINT,
                    API_KEY,
                    DOCUMENT_UPLOAD_ENDPOINT
                )
            );
        } catch (Exception ex) {
            System.debug('Error scheduling Apex job for Lead: ' + ex.getMessage());
        }
    }
}