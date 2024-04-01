public class ScheduleRoundupIntegration implements Schedulable {
    private String smartAdvocateModelJson;
    private String leadId;
    
    public ScheduleRoundupIntegration(String smartAdvocateModelJson, String leadId) {
        this.smartAdvocateModelJson = smartAdvocateModelJson;
        this.leadId = leadId;
    }
    
    public void execute(SchedulableContext context) {
        // Now call the sendLeadDataAsync method
        SmartAdvocateIntegration.sendLeadDataAsync(smartAdvocateModelJson, leadId);
        
        // Add additional processing after the data is sent
        List<Id> leastOfLeads = new List<Id> { leadId };
        SmartAdvocateEmailHandler.sendEmailOnRetainerSigned(leastOfLeads);
    }
}