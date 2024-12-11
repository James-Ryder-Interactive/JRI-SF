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
        this.documentUploadEndpoint = apiKey;
    }
    
    public void execute(SchedulableContext context) {
        // Now call the sendLeadDataAsync method
        SmartAdvocateIntegration.sendLeadDataAsync(smartAdvocateModelJson, leadId, leadDataEndpoint, apiKey, documentUploadEndpoint);
 
        // Add additional processing after the data is sent ---- THIS WAS ONLY RELATED TO ROUNDUP
        /*if(shouldSendEmail = true) {
            System.debug( 'shouldSendEmail: ' + shouldSendEmail);
            List<Id> leastOfLeads = new List<Id> { leadId };
            SmartAdvocateEmailHandler.sendEmailOnRetainerSigned(leastOfLeads);
        }*/
    }
}