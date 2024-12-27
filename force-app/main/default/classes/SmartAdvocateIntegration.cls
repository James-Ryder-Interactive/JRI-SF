public class SmartAdvocateIntegration {
    public static String caseNumber;

// Method to create HTTP Request dynamically
	private static HttpRequest createHttpRequest(
        String endpoint, 
        String method, 
        String requestBody, 
        String contentType
    ) {        
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod(method);
        request.setHeader('Content-Type', contentType);
        request.setBody(requestBody); 
        request.setTimeout(120000);
        System.debug('requestBody :: ' + requestBody);

		return request;
      
	}
    
// Method to send lead data to the external system
    public static String sendLeadData(String endpoint, Object leadData) {

        //String requestBody = JSON.serialize(leadData); 

        // Make the HTTP request
        HttpRequest request = createHttpRequest(endpoint, 'POST', JSON.serialize(leadData), 'application/json');
        Http http = new Http();
        HttpResponse response;
        
        try {
            response = http.send(request);
            System.debug('Response Body: ' + response.getBody());
            System.debug('Response Status Code: ' + response.getStatusCode());

        } catch (Exception e) {
            System.debug('Error sending lead data: ' + e.getMessage());
            return 'Error';
        }

        if (response.getStatusCode() != 200) {
            System.debug('Error sending lead data' + response.getBody());
            return 'Error';
        } else {
            System.debug('Lead data sent:'  + response.getBody());
            Map<String, Object> leadResponse = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            return String.valueOf(leadResponse.get('result'));
        }
    }

// Method to send documents
    public static void sendDocument(
        String endpoint,
        String apiKey,
        Blob documentData,
        String filename
    ) {
        //String Category = 'Plaintiff';
      	//String encodedSubCategory = EncodingUtil.urlEncode(subCategory, 'UTF-8').replace('+', '%20');
        //String encodedFilename = EncodingUtil.urlEncode(filename, 'UTF-8').replace('+', '%20');

        //String endpoint = 'https://sa.krauseandkinsman.com/sasvc/SAWebService.svc/receiver/UploadDocument?filename=' + encodedFilename + '&SACaseNumber=' + caseID + '&Category=Plaintiff&SubCategory=' + encodedSubCategory;
                       
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        System.debug('endpoint :::: ' + endpoint);
        request.setMethod('POST');
        request.setHeader('X-ApiKey', apiKey);
        request.setHeader('Content-Type','application/pdf');        
        request.setBodyAsBlob(documentData);

        System.debug('requestBody :: ' + request.getBodyAsBlob());
        
        Http http = new Http();
        HttpResponse response;

        try {
            response = http.send(request);
        } catch (Exception e) {
            System.debug('Error sending document: ' + e.getMessage());
            return;
        }
        
        if (response.getStatusCode() != 200) {
            System.debug('Error sending document: ' + response.getBody());
        } else {
            System.debug('Document sent successfully:');
        }
    }   

    public static void processDocuments(
        String caseID,
        String leadID,
        String apiKey, 
        String documentUploadEndpoint
    ) {
        // Retrieve all attachments related to the Lead (ContentVersion + Attachment)
        List<ContentDocumentLink> attachments = [
            SELECT Id, ContentDocumentId
            FROM ContentDocumentLink 
            WHERE LinkedEntityId = :Id.valueOf(leadID)
        ];

        // Extract ContentDocumentIds from attachments
        Set<Id> contentDocumentIds = new Set<Id>();
        for (ContentDocumentLink attachment : attachments) {
            contentDocumentIds.add(attachment.ContentDocumentId);
        }

        // Query all related ContentVersions
        List<ContentVersion> contentVersions = [
            SELECT Title, VersionData, ContentDocumentId, FileExtension
            FROM ContentVersion
            WHERE ContentDocumentId IN :contentDocumentIds AND IsLatest = true
        ];

        // Loop through the ContentVersions and process them
        for (ContentVersion contentVersion : contentVersions) {
            System.debug('Processing ContentVersion: ' + contentVersion);

            String subCategory = contentVersion.Title.contains('Retainer') ? 'Retainer Agreement' : 
                                contentVersion.Title.contains('Intake') ? 'Questionnaire' : 'Proof of Claim';

            String category = 'Client Docs';
            String filename = caseID + '_' + category + '_' + subCategory + '.' + contentVersion.FileExtension;
            
            String endpoint = documentUploadEndpoint + 
                '?filename=' + EncodingUtil.urlEncode(filename, 'UTF-8') +
                '&SACaseNumber=' + caseID + 
                '&Category=' + EncodingUtil.urlEncode(category, 'UTF-8') + 
                '&SubCategory=' + EncodingUtil.urlEncode(subCategory, 'UTF-8');

            sendDocument(endpoint, apiKey, contentVersion.VersionData, filename);
        }

        // Now, handle Attachments (those in the Attachment object)
        List<Attachment> attachmentsToProcess = [
            SELECT Id, Name, Body, ContentType
            FROM Attachment 
            WHERE ParentId = :Id.valueOf(leadID)
        ];

        for (Attachment attachment : attachmentsToProcess) {
            String attachmentName = attachment.Name;
            String fileExtension = attachmentName.substring(attachmentName.lastIndexOf('.') + 1);

            String subCategory = attachment.Name.contains('Retainer') ? 'Retainer Agreement' : 
                    attachment.Name.contains('Intake') ? 'Questionnaire' : 'Proof of Claim';

            String category = 'Client Docs';
            String filename = caseID + '_' + category + '_' + subCategory + '.' + fileExtension;

            String endpoint = documentUploadEndpoint + 
                '?filename=' + EncodingUtil.urlEncode(filename, 'UTF-8') + 
                '&SACaseNumber=' + caseID + 
                '&Category=' + EncodingUtil.urlEncode('Client Docs', 'UTF-8') +
                '&SubCategory=' + EncodingUtil.urlEncode('Other', 'UTF-8');
            
            sendDocument(endpoint, apiKey, attachment.Body, filename);
        }
    }

// Asynchronous method to send lead data and documents    
	@future(callout=true)
    public static void sendLeadDataAsync(
        String leadDataJson,
        String leadID,
        String leadDataEndpoint, 
        String apiKey, 
        String documentUploadEndpoint
    ) {
        try {
            System.debug('leadDataJson: ' + leadDataJson);
            Object dataModel = JSON.deserializeUntyped(leadDataJson);
            System.debug('dataModel: ' + dataModel);       
            caseNumber = sendLeadData(leadDataEndpoint, dataModel);
            System.debug('caseNumber: ' + caseNumber);       

            if (caseNumber != null && caseNumber != 'Error') {
                processDocuments(caseNumber, leadID, apiKey, documentUploadEndpoint);
            }
        } catch (Exception e) {
            System.debug('Error in sendLeadDataAsync: ' + e.getMessage());
        }
    }    
}