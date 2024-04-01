public class FacebookCAPIIntegration {
    public static HttpRequest sendEvent(String accessToken, String pixelID, Map<String, Object> eventData) {
        //String accessToken = 'EAAJyohiQ73sBOxeZBjAZCYbS1BrIDpbJM9j6zXG14vFYZAXM4HdlAdKfFwXY8SUrVe2g8vIqI6t0NQxqT6VDnGtXgZC8jdM5liXxDYGeK71Em0yS5WLqVxOrTtYCQkhZCSzp9cpy09RwqoT3ZAOmh7IZBpPnsWTXZB3qGDpiNXbHZC3JcO0QoAOLJILfZCXMMEPuFSAAZDZD';
        String apiUrl = 'https://graph.facebook.com/v17.0/' + pixelID + '/events?access-token=' + accessToken;
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(apiUrl);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Authorization', 'Bearer ' + accessToken);
        
        req.setBody(JSON.serialize(eventData));
        System.debug('JSON.serialize(eventData) :: ' + JSON.serialize(eventData));
        System.debug('Request :::: ' + req);
        Http http = new Http();
        HttpResponse res = http.send(req);
        System.debug('Response :::: ' + res);
        // Handle response if needed
         try {
			return req;
		} catch (Exception e) {
            System.debug('Error creating HTTP request: ' + e.getMessage());
        }       
         return null; // Handle the case where the request couldn't be created
    }
}