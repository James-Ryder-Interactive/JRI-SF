public virtual class EvergreenModel {
    
    public String CallerPhoneNumber;
    public DateTime DateRetainerSent;
    public DateTime DateRetainerReceived;
    public String SoughtCompensationAlready;
    public String LeadID;
    public String CallerAddressStreet;
    public String CallerAddressCity;
    public String CallerAddressZIP;
    public String CallerAddressState;
    public String InjuredPartyPhone;
    public String InjuredPartyEmployer;
    public String ReceivedVABenefits;
    public String InjuredPartyAddressStreet;
    public String InjuredPartyAddressCity;
    public Date CallerDateofBirth;
    public String CallerEmail;
    public String CallerFirstName;
    public String CallerMiddleName;
    public String CallerLastName;
    public String InjuredPartyAddressState;
    public String InjuredPartyAddressZIP;
    public String Areyoucallingforyourselforsomeone;
    public Date InjuredPartyDateofBirth;
    public String Lovedonealiveordeceased;
    //public Date ExposureEndDate;
    public String InjuredPartyFirstName;
    public String InjuredPartyMiddleName;
    public String InjuredPartyLastName;
    //public Date ExposureStartDate;
    public Date CallDate;
    public Date RetainerReceivedTimestamp;
    public Date PaperDocsRequestedTimestamp;
    public Date RetainerSentTimestamp;
    public Date ContactingTimestamp;
    public Date NewTimestamp;
    public Time CallTime;
    public String InjuredPartyMaritalStatus;
    public Date InjuredPartyDateofDeath;
    public String InjuredPartyEmail;
    public String LeadStatus;
    public String PaperDocsOrDigital;
    public String AdditionalInfo;
    public String AdditionalNotes;
    public String RelationshipToInjuredParty;
    public String MassTortName;
    public Date ExposureEndDate;
    public Date ExposureStartDate;
    public String CallerRecordedConsent;
    public String InjuredPartySSN;
    public String TimeZone;
    public String ContactingConsent;
        
    public EvergreenModel() {
        // Map fields from Lead

    }
    
    public EvergreenModel(Lead lead) {
        // Map fields from Lead
        LeadID = lead.Id;
        CallerRecordedConsent = lead.Caller_Recorded_Consent__c;
		ContactingConsent = lead.Contacting_Consent__c;
        CallerFirstName = lead.FirstName;
        CallerMiddleName = lead.MiddleName;
        CallerLastName = lead.LastName;
        CallerAddressCity = lead.City;
        CallerAddressState = lead.State; 
        CallerAddressStreet = lead.Street;
        CallerAddressZIP = lead.PostalCode; 
        CallerPhoneNumber = lead.Phone; 
        CallerEmail = lead.Email;
        CallDate = lead.CreatedDate?.date();
        Areyoucallingforyourselforsomeone = lead.Calling_for_yourself__c;
        PaperDocsOrDigital = lead.Signature_Mail_Request__c;
        AdditionalInfo = lead.Additional_Notes__c;
        AdditionalNotes = lead.Additional_Notes__c;
        TimeZone = lead.Time_Zone__c;
        
        if (lead.Status == 'Qualified' || lead.Status == 'Working') {
            LeadStatus = 'Contacting';
        } else if (lead.Status == 'Not Interested') {
            LeadStatus = 'Refused Help';
        } else if (lead.Status == 'Retainer Signed') {
            LeadStatus = 'Retainer Received';
        } else {
            LeadStatus = lead.Status;
        }
    }
    
        public class AilmentData {
        public Date DateOfDiagnosis;
        public String Ailment;
        public String AilmentTypeSpecific;
        public String AilmentStage;
	}
}