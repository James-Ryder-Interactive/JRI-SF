@isTest
public class HttpResponseGeneratorTest {
@isTest static void testHttpResponseGenerator() {
        // Define the expected JSON response
        String expectedResponse = '{"id": "12344", "name": "Test Page", "website": "www.example.com", "fan_count": "1000"}';

        // Instantiate the HttpResponseGenerator class with the expected response
        HttpResponseGenerator responseGenerator = new HttpResponseGenerator(expectedResponse);

        // Create a mock HttpRequest for the sake of testing
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://www.example.com');
        req.setMethod('GET');

        // Get the mock HttpResponse from the response generator
        HttpResponse res = responseGenerator.respond(req);

        // Verify that the response matches the expected JSON
        System.assertEquals(expectedResponse, res.getBody());
        System.assertEquals('application/json', res.getHeader('Content-Type'));
        System.assertEquals(200, res.getStatusCode());
    }
}