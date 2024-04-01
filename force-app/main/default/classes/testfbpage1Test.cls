@isTest
private class testfbpage1Test {
    @isTest static void testFbPage1() {
        // Set up a mock response
        String jsonResponse = '{"id": "123", "name": "Test Page", "website": "https://graph.facebook.com", "fan_count": "1000"}';
        Test.setMock(HttpCalloutMock.class, new HttpResponseGenerator(jsonResponse));

        // Instantiate the testfbpage1 class
        testfbpage1 fbPage = new testfbpage1();

        // Verify the values are correctly set
        System.assertEquals('123', fbPage.id1);
        System.assertEquals('Test Page', fbPage.name1);
        System.assertEquals('https://graph.facebook.com', fbPage.website1);
        System.assertEquals('1000', fbPage.fancount1);
    }
}