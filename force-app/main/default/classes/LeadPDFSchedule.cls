public with sharing class LeadPDFSchedule implements Schedulable {
    private String leadId;
    
    public LeadPDFSchedule (String leadId) {
        this.leadId = leadId;
    }

    public void execute(SchedulableContext context) {
        try {
            LeadPDFGenerator.generateAndAttachPDF(leadId);
        } catch (Exception e) {
            System.debug('Error in LeadPDFScheduler: ' + e.getMessage());
        }
    }

    // Method to schedule the job (can be called from anonymous Apex or other classes)
    public static void scheduleJob(Id leadId) {

        String year = String.valueOf(Datetime.now().year());
        String month = Datetime.now().format('MMM').toUpperCase();
        String day = String.valueOf(Datetime.now().day());
        String hour = String.valueOf(Datetime.now().hour());
		String min = String.valueOf(Datetime.now().minute() + 2);
		String ss = String.valueOf(Datetime.now().second());

        String nextFireTime = ss + ' ' + min + ' ' + hour + ' ' +  day + ' ' + month + ' ? ' + year;
        System.debug('nextFireTime ::: ' + nextFireTime);

        LeadPDFSchedule job = new LeadPDFSchedule(leadId);
        System.schedule('Lead PDF Generation_' + leadId + System.now(), nextFireTime, job);
    }
}