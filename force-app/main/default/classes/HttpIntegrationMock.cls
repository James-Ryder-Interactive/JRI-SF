@isTest
public class HttpIntegrationMock implements HttpCalloutMock {
    // Static variables to store the request and response
    public static HttpRequest lastRequest;
    public static HttpResponse responseToReturn;

    public HTTPResponse respond(HTTPRequest req) {
        // Capture the request
        lastRequest = req;

        // Create a mock HTTPResponse
        HttpResponse res = new HttpResponse();
        res.setStatusCode(200);
        res.setBody('{"success": true}');

        // Capture the response
        responseToReturn = res;

        return res;
    }

    // Getter methods to access the request and response
    public static HttpRequest getLastRequest() {
        return lastRequest;
    }

    public static HttpResponse getResponseToReturn() {
        return responseToReturn;
    }
}