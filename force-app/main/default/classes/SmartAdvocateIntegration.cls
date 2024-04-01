public class SmartAdvocateIntegration {
    public static String caseNumber;
    
	private static HttpRequest createHttpRequest(String endpoint, String method, String requestBody, String contentType) {        
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod(method);
        request.setHeader('Content-Type', contentType);
        request.setBody(requestBody); 
        request.setTimeout(120000);
        System.debug('requestBody :: ' + requestBody);

        try {
			return request;
		} catch (Exception e) {
            System.debug('Error creating HTTP request: ' + e.getMessage());
            return null;
        }       
	}
    
    // Method to send lead data to the external system
    public static String sendLeadData(Object leadData) {
        // Make the HTTP request
        HttpRequest request = createHttpRequest('https://sa.krauseandkinsman.com/saservice/sawebservice.svc/Receiver/OfficeCalls/e1dd0dd0cb194999ac4495a7ebeb9213', 'POST', JSON.serialize(leadData), 'application/json');        
        Http http = new Http();
        request.setTimeout(120000);
        HttpResponse response = http.send(request);
		       
        if (response.getStatusCode() != 200) {
            System.debug('Error sending lead data: ' + response.getBody());
            return 'Error';
        } else {
            System.debug('Lead data sent successfully');
            System.debug('lead data sent! Response body:: ' + response.getBody());
            Map<String, Object> leadResponse = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());

            return (String) leadResponse.get('result');
        }
    }

    public static void sendDocument(String caseID, Blob documentData, String subCategory, String filename) {
        String Category = 'Plaintiff';
      	String encodedSubCategory = EncodingUtil.urlEncode(subCategory, 'UTF-8').replace('+', '%20');
        String encodedFilename = EncodingUtil.urlEncode(filename, 'UTF-8').replace('+', '%20');

        String endpoint = 'https://sa.krauseandkinsman.com/sasvc/SAWebService.svc/receiver/UploadDocument?filename=' + encodedFilename + '&SACaseNumber=' + caseID + '&Category=Plaintiff&SubCategory=' + encodedSubCategory;
                       
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('POST');
        request.setHeader('X-ApiKey', '9b15c2857fee41b2aa37dfb0199be52b');
        request.setHeader('Content-Type','application/pdf');        
        request.setBodyAsBlob(documentData);
        
        Http http = new Http();
        request.setTimeout(120000);
        HttpResponse response = http.send(request);
        
        if (response.getStatusCode() != 200) {
            System.debug('Error sending document: ' + response.getBody());
        } else {
            System.debug('Document sent successfully');
        }	
    }   

    public static void processDocuments(String caseID, String leadID) {
        List<ContentDocumentLink> attachments = [SELECT Id, ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId = :leadID];

        for (ContentDocumentLink attachment : attachments) {
            ContentVersion contentVersion = [SELECT Id, Title, FileType, VersionData, PathOnClient FROM ContentVersion WHERE ContentDocumentId = :attachment.ContentDocumentId AND IsLatest = true LIMIT 1];

            if (contentVersion != null) {
                String subCategory = contentVersion.Title.contains('Roundup CFA') ? 'Retainer Agreement' : 'Authorization Medical';
                String filename = caseID + '_Plaintiff_' + subCategory + '.pdf';
    
                sendDocument(caseID, contentVersion.VersionData, subCategory, filename);
            }
        }
    }
    
	@future(callout=true)
    public static void sendLeadDataAsync(String leadDataJson, String leadID) {
        Object dataModel = JSON.deserializeUntyped(leadDataJson);       
        caseNumber = sendLeadData(dataModel);
        processDocuments(caseNumber, leadID);
    }    
}