trigger LeadTrigger on Lead (after insert, after update) {
    
    // Handle after insert
    if (Trigger.isInsert) {
        for (Lead lead : Trigger.new) {
            if (lead.Status == 'Qualified') {
                LeadTriggerHandler.sendRetainerOnStatusUpdate(lead.Id);
            }

            if ((lead.Status == 'Qualified' || lead.Status == 'Retainer signed') && lead.Campaign__r.Name == 'Powerport') {
                LeadTriggerHandler.sendEventToMeta(lead.Id);
            }
        }
    }

    // Handle after update
    if (Trigger.isUpdate) {
        for (Lead lead : Trigger.new) {
            Lead oldLead = Trigger.oldMap.get(lead.Id);
            if (lead.Status == 'Qualified' && oldLead.Status != 'Qualified') {
                LeadTriggerHandler.sendRetainerOnStatusUpdate(lead.Id);
            }

            if (((lead.Status == 'Qualified'  && oldLead.Status != 'Qualified') || (lead.Status == 'Retainer signed'  && oldLead.Status != 'Retainer signed')) && lead.Campaign__r.Name == 'Powerport') {
                LeadTriggerHandler.sendEventToMeta(lead.Id);
            }
        }
    }
}