public class SmartAdvocateSchedule implements Schedulable {
    private String smartAdvocateModelJson;
    private String leadId;
    private String leadDataEndpoint; 
    private String apiKey; 
    private String documentUploadEndpoint;
    
    public SmartAdvocateSchedule (
        String smartAdvocateModelJson,
        String leadId,
        String leadDataEndpoint,
        String apiKey,
        String documentUploadEndpoint
    ) {
        this.smartAdvocateModelJson = smartAdvocateModelJson;
        this.leadId = leadId;
        this.leadDataEndpoint = leadDataEndpoint;
        this.apiKey = apiKey;
        this.documentUploadEndpoint = documentUploadEndpoint;
    }
    
    public void execute(SchedulableContext context) {
        // Now call the sendLeadDataAsync method
        SmartAdvocateIntegration.sendLeadDataAsync(smartAdvocateModelJson, leadId, leadDataEndpoint, apiKey, documentUploadEndpoint);
 
        List<Id> leastOfLeads = new List<Id> { leadId };
        SmartAdvocateEmailHandler.sendEmailOnRetainerSigned(leastOfLeads);
    }
}