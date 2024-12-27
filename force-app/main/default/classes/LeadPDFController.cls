public with sharing class LeadPDFController {
    public Lead lead { get; set; }
    public Case_Details__c caseDetails { get; set; }
    public Client_Information__c clientInformation { get; set; }

    public LeadPDFController(ApexPages.StandardController controller) {
        Id leadId = controller.getId();
        // Query the Lead
        lead = [
            SELECT Id, FirstName, LastName, Email, Phone, Street, City, State, PostalCode,
                   Date_of_Birth__c, MobilePhone, Caller_Recorded_Consent__c, Contacting_Consent__c,
                   SSN__c, Additional_Notes__c, Company__r.Name, Call_Outcome__c, Other_Name__c
            FROM Lead
            WHERE Id = :leadId
            LIMIT 1
        ];

        // Query related Case Details
        List<Case_Details__c> caseDetailsList = [
            SELECT Id, Spoken_to_Another_Attorney__c, Resided_in_CA_During_Booking__c, 
                Used_Marriott_Website__c, Browser_Type_Used__c, Device_Type_Used__c, 
                Have_Marriott_Bonvoy_Account__c, Privacy_Tools_Enabled__c, 
                Facebook_Account_During_Booking__c, Logged_Into_Facebook_During_Booking__c, 
                Logged_Into_Facebook_90_Days_Prior__c, Refused_to_Provide_SSN__c, 
                Will_Provide_SSN__c, Proof_Received__c, Date_Mariott_Website_Visited__c, 
                Visited_Website_on_Laptop__c, Non_Mobile_Device_Setup__c
            FROM Case_Details__c
            WHERE Lead__c = :leadId
            LIMIT 1
        ];

        // Check if caseDetails list is not empty before processing
        if (!caseDetailsList.isEmpty()) {
            caseDetails = caseDetailsList[0];  // Access the first (and only) record
            // Process the case detail here
            System.debug('Case Detail found: ');
        } else {
            System.debug('No Case Details found for Lead ID: ' + leadId);
        }
        System.debug('caseDetails ::: ' + caseDetails);

        // Query related Client Information
        List<Client_Information__c> clientInformationList = [
            SELECT Id, Emergency_Contact_Name__c, Emergency_Contact_Phone__c, 
                   Have_Permission_to_Contact_Emergency__c, Have_Permission_to_Reference_Case__c,
                   Date_of_Birth__c, United_States_Resident__c
            FROM Client_Information__c
            WHERE Lead__c = :leadId
            LIMIT 1
        ];

        // Check if clientInformation list is not empty before processing
        if (!clientInformationList.isEmpty()) {
            clientInformation = clientInformationList[0];  // Access the first (and only) record
            // Process the case detail here
        } else {
            System.debug('No Case Details found for Lead ID: ' + leadId);
        }
    }
}