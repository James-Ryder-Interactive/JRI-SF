trigger sendEventOnLeadUpdate on Lead (after insert, after update) {
    List<FacebookCAPIQueueable> queueables = new List<FacebookCAPIQueueable>();
    
    for (Lead lead  : Trigger.new) {
        //Lead oldLead = Trigger.oldMap.get(lead.Id);
        if (lead.Status == 'Qualified') {
            System.enqueueJob(new FacebookCAPIQueueable(lead.Id));
    	}
    }
}