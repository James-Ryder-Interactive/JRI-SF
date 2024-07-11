public class SendSignatureRequestWithTemplate {
    
    public static void generateHelloSignature(String email, String name, Id talcId, String templateName){
        Id sfdcTemplateId = [SELECT Id FROM HelloSign__Template__c WHERE Name = :templateName][0]?.Id;
        
        List<HelloSign__SignerRole__c> role = [
            SELECT Id, HelloSign__SpecificEmail__c, HelloSign__SpecificFirstName__c
            FROM HelloSign__SignerRole__c
            WHERE HelloSign__Template__c = :sfdcTemplateId];
		
        for(HelloSign__SignerRole__c ro : role){
            ro.HelloSign__SpecificEmail__c = email;
            ro.HelloSign__SpecificFirstName__c = name;
        }
        update role;

        List<HelloSign.SendWithTemplate.SendObject> sos = 
          new List<HelloSign.SendWithTemplate.SendObject>();
        
        HelloSign.SendWithTemplate.SendObject so = 
          new HelloSign.SendWithTemplate.SendObject(talcId, sfdcTemplateId);
        sos.add(so);
        
        // Pass List to sendWithTemplate method
        HelloSign.SendWithTemplate.sendWithTemplate(sos);
    }
}