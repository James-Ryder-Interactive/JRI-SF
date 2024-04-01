public class HttpResponseGenerator implements HttpCalloutMock{
    private String response;

    public HttpResponseGenerator(String response) {
        this.response = response;
    }

    public HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody(response);
        res.setStatusCode(200);
        return res;
    }
}