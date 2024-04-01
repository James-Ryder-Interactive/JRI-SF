@isTest
public class EvergreenIntegrationTest {
 	@isTest
    public static void testSendEvent() {
        // Set up test data and context if needed
        
        // Create a mock response
        HttpCalloutMock mock = new HttpIntegrationMock();
        
        // Start test, associate the mock with a callout
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, mock);
      	EvergreenModel model = new EvergreenModel();
        EvergreenDocumentModel documentModel = new EvergreenDocumentModel();
        String leadDataJson = JSON.serializePretty(model);
        String docJson1 = JSON.serializePretty(documentModel);
        
        // Call the method you want to test
        EvergreenIntegration.sendLeadData(model);
        EvergreenIntegration.sendDocument(documentModel);
        EvergreenIntegration.sendLeadDataAsync(leadDataJson);
        EvergreenIntegration.sendDocumentAsync(docJson1);
        
        // Stop test
        Test.stopTest();
        
        // Perform assertions
        System.assertEquals(200, HttpIntegrationMock.getResponseToReturn().getStatusCode());
    }
}