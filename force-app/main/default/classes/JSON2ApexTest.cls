@isTest
public class JSON2ApexTest {
 @isTest
    public static void testParse() {
        String json = '{"id":"12345688",' +
                       '"name":"Test Page",' +
                       '"website":"https://graph.facebook.com",' +
                       '"fan_count":"200"' +
                       '}';

        JSON2Apex parsedJson = JSON2Apex.parse(json);

        // Assertions for top-level attributes
        System.assertEquals('12345688', parsedJson.id);
        System.assertEquals('Test Page', parsedJson.name);
        System.assertEquals('https://graph.facebook.com', parsedJson.website);
        System.assertEquals('200', parsedJson.fan_count);
	}
}