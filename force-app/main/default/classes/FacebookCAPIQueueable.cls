public class FacebookCAPIQueueable implements Queueable {
	private String leadId;

    public FacebookCAPIQueueable(String leadId) {
        this.leadId = leadId;
    }

    @Future(callout=true)
    public static void sendEventToFacebook(String leadId) {
		List<Lead> leads = [SELECT Id, FirstName, LastName, Address, City, State, Country, PostalCode, Email, Phone, Company__c, Company__r.Name, 
                            Campaign__c, Campaign__r.Name, Status FROM Lead WHERE Id = :leadId LIMIT 1];
        Lead lead = new Lead();
        String leadFirstName;
        String leadLastName;
        //String leadAddress;
        String leadEmail;
        String leadPhone;
        String city;
        String state;
        String country;
        String postalCode;
    	String ipAddress = '2a02:27b0:4d03:9000:e9fa:ca2d:52f1:2889';
        
        if (!leads.isEmpty()) {
            lead = leads[0];
            leadFirstName = lead.FirstName;
            leadLastName = lead.LastName;
            leadEmail = String.ValueOf(lead.Email);
            leadPhone = lead.Phone;
            city = String.valueOf(lead.City);
            state = String.valueOf(lead.State);
            country = String.valueOf(lead.Country);
            postalCode = String.valueOf(lead.PostalCode);
        }
        
        Map<String, Object> eventData = new Map<String, Object>();       
        
        Map<String, Object> userData = new Map<String, Object>();
        userData.put('client_ip_address', ipAddress);
        userData.put('client_user_agent', 'crm');
        userData.put('em', genrateHashValue(leadEmail, true));
        userData.put('ph', genrateHashValue(leadPhone, false));
        userData.put('fn', genrateHashValue(leadFirstName, false));
        userData.put('ln', genrateHashValue(leadLastName, false));
        userData.put('external_id', lead.Id);
        userData.put('ct', genrateHashValue(city, false));
        userData.put('st', genrateHashValue(state, false));
        userData.put('country', genrateHashValue(country, false));
        userData.put('zp', genrateHashValue(postalCode, false));
        
        // Add other user data fields as needed               
        Map<String, Object> customData = new Map<String, Object>();      
        
        //customData.put('address', leadAddress);
        customData.put('external_id', String.valueOf(lead.id));
        customData.put('currency', 'USD');
        customData.put('value', '1.0');
        customData.put('content_type', 'product');
         
        List<Map<String, Object>> dataList = new List<Map<String, Object>>();

        Map<String, Object> mainData = new Map<String, Object>();
        mainData.put('event_name', 'Purchase');
		mainData.put('event_time', String.valueOf(System.now().getTime() / 1000));
        mainData.put('event_source_url', 'https://jrinteractive--jripart.sandbox.my.salesforce.com/');
		mainData.put('action_source', 'system_generated');
        mainData.put('user_data', userData);
        mainData.put('custom_data', customData);
        
        dataList.add(mainData);
		eventData.put('data',  new List<Map<String, Object>>{mainData});
       	     
        if (lead.Campaign__r.Name == 'Powerport' && lead.Company__r.Name == 'NGK Law - Bard'){
            CAPI_Oauth_Settings__mdt oAuthDetails = CAPI_Oauth_Settings__mdt.getInstance('JRI_Port');
        	FacebookCAPIIntegration.sendEvent(oAuthDetails.Access_Token__c, oAuthDetails.Pixel_ID__c, eventData);
        } else if (lead.Campaign__r.Name == 'Camp Lejeune' && lead.Company__r.Name == 'Saddle Rock') {
            System.debug('cmpl');
            CAPI_Oauth_Settings__mdt oAuthDetailsCMPL = CAPI_Oauth_Settings__mdt.getInstance('JRI_Camp_Lejuene');
            FacebookCAPIIntegration.sendEvent(oAuthDetailsCMPL.Access_Token__c, oAuthDetailsCMPL.Pixel_ID__c, eventData);
        }
    }
    
    public void execute(QueueableContext context) {
        sendEventToFacebook(leadId);
    }
    
    public static String genrateHashValue(String input, Boolean isEmail) {
        String cryptoSalt = '249D5EC76175B12A';
        Blob cryptoKey=Blob.valueof('J@NcRfUjXn2r5u8x/A?D(G-KaPdSgVkY');
        //Blob cryptoKey = crypto.generateAesKey(256);
        Blob cryptoIv = Blob.valueof('4t6w9z$C&F)J@NcR');
        Blob data;
        if (isEmail == true && input != null) {
            data = Blob.valueOf(input);
        } else {
            data = Blob.valueOf(input + cryptoSalt);
        }
        
        Blob encryptedData = Crypto.encrypt('AES256', cryptoKey, cryptoIv, data);
        String encodeDataHex = EncodingUtil.convertToHex(encryptedData);
        System.debug('>>> encodeDataHex >>> ' + encodeDataHex);
        
        return encodeDataHex;
    }
    
}