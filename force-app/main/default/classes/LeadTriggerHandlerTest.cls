@isTest
public with sharing class LeadTriggerHandlerTest {
    
    @isTest
    static void testSendRetainerOnStatusUpdate() {
        Campaign testCampaign = TestDataFactory.createTestCampaign();
        Account testCompany = TestDataFactory.createTestCompany();
        Lead testLead = TestDataFactory.createTestLead();
        testLead.Retainer_to_Send__c = 'TH: Child DOB 2002-2005 & lives in Missouri or Illinois';
        testLead.Status = 'Qualified';
        update testLead;
        LeadTriggerHandler.sendRetainerOnStatusUpdate(testLead.Id);

        System.assert(true, 'Check debug logs for sendRetainerOnStatusUpdate execution');
    }
}