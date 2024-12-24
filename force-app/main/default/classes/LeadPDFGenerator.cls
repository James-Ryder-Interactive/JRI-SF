public with sharing class LeadPDFGenerator {
    @future(callout = true)
    public static void generateAndAttachPDF(Id leadId) {
        try {
            // Generate PDF from Visualforce page
            PageReference pdfPage = Page.LeadPDF;  // Use your Visualforce page's name
            pdfPage.getParameters().put('id', leadId);  // Pass the Lead ID to the page
            Blob pdfBlob = pdfPage.getContentAsPDF();

            // Create ContentVersion (file) record
            ContentVersion contentVersion = new ContentVersion();
            contentVersion.Title = 'Intake_' + leadId;
            contentVersion.PathOnClient = 'Intake_' + leadId + '.pdf';
            contentVersion.VersionData = pdfBlob;
            insert contentVersion;

            // Link the file to the Lead
            ContentDocumentLink contentDocumentLink = new ContentDocumentLink();
            contentDocumentLink.ContentDocumentId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :contentVersion.Id].ContentDocumentId;
            contentDocumentLink.LinkedEntityId = leadId;
            contentDocumentLink.ShareType = 'I'; // 'I' for Inferred
            insert contentDocumentLink;

            System.debug('Attachment created and inserted for Lead ID: ' + lead.Id);
        } catch (Exception e) {
        System.debug('Error generating PDF: ' + e.getMessage());
        }
    }
}