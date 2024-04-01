public class EvergreenIntegration {

	private static HttpRequest createHttpRequest(String endpoint, String method, String requestBody) {
        
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod(method);
        request.setHeader('Content-Type', 'application/json');
        request.setBody(requestBody); 
        System.debug('requestBody :: ' + requestBody);

        try {
			return request;
		} catch (Exception e) {
            System.debug('Error creating HTTP request: ' + e.getMessage());
        }       
         return null; // Handle the case where the request couldn't be created
	}
    
    // Method to send lead data to the external system
    public static String sendLeadData(Object leadData) {
        // Make the HTTP request
        HttpRequest request = createHttpRequest('https://evergreenmediagroup--partial.sandbox.my.salesforce-sites.com/services/apexrest/Data', 'POST', JSON.serialize(leadData));        
        Http http = new Http();
        HttpResponse response = http.send(request);
		
        System.debug('response :: ' + response);
        
        if (response.getStatusCode() != 200) {
            System.debug('Error sending lead data: ' + response.getBody());
            // Handle error here
            return 'Error';
        } else {
            System.debug('Lead data sent successfully');
            return 'Success';
        }
    }
    
	public static void sendDocument(EvergreenDocumentModel leadData) {
        // Make the HTTP request for document
        HttpRequest request = createHttpRequest('https://evergreenmediagroup--partial.sandbox.my.salesforce-sites.com/services/apexrest/download', 'POST', JSON.serialize(leadData).replace('PotentialLeadID','Lead_ID__c'));
        
        Http http = new Http();
        HttpResponse response = http.send(request);
		
        System.debug('response 2 :: ' + response);
        
        if (response.getStatusCode() != 200) {
            System.debug('Error sending document: ' + response.getBody());
            // Handle error here 
        } else {
            System.debug('Document sent successfully');
        }
    }

	@future(callout=true)
    public static void sendLeadDataAsync(String leadDataJson) {
        Object dataModel = JSON.deserializeUntyped(leadDataJson);       
        sendLeadData(dataModel);
    }
    
	@future(callout=true)
    public static void sendDocumentAsync(String leadDocDataJson) {
        EvergreenDocumentModel documentModel = (EvergreenDocumentModel)JSON.deserialize(leadDocDataJson, EvergreenDocumentModel.class);
        sendDocument(documentModel);       
    }   
}