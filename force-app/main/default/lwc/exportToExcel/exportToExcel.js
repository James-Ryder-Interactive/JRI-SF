import { LightningElement, api } from 'lwc';
import SheetJS from '@salesforce/resourceUrl/SheetJS'; // The static resource for SheetJS
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
import getNECLeadsList from '@salesforce/apex/LeadController.getNECLeadsList'; // Import the Apex method

export default class ExportToExcel extends LightningElement {
    @api fileName = 'NecDataExport-' + new Date().toJSON().slice(0, 10);
    @api excelData = [];
    version;

    async connectedCallback() {
        await loadScript(this, SheetJS); // load the library
        // At this point, the library is accessible with the `XLSX` variable
        this.version = XLSX.version;  
        await this.fetchData();
    }

    get disableExportButton() {
        return !(this.fileName && this.excelData.length);
    }

    // Function to format date and time
    formatDateTime = (dateStr) => {
        const date = new Date(dateStr);
        return date.toLocaleString('en-US', {
            month: 'numeric',
            day: 'numeric',
            year: 'numeric',
            hour: 'numeric',
            minute: 'numeric',
            hour12: true
        });
    };

    async fetchData() {
        try {
            const result = await getNECLeadsList();
            if (result && result.length > 0) {
                this.excelData = result.map(obj => ({
                    Id : obj.Id,
                    FirstName : obj.FirstName,
                    LastName : obj.LastName,
                    Company : obj.Company__c,
                    Campaign : obj.Campaign__c,
                    Status : obj.Status,
                    Email : obj.Email,
                    Phone : obj.Phone,
                    "Mobile Phone" : obj.MobilePhone,
                    "Additional Notes" : obj.Additional_Notes__c,
                    "Signature Mail Request" : obj.Signature_Mail_Request__c,
                    "Retainer to Send" : obj.Retainer_to_Send__c,
                    "Date Retainer Sent": obj.Date_Retainer_Sent__c ? this.formatDateTime(obj.Date_Retainer_Sent__c) : '',
                    "Date Signed": obj.Date_Signed__c ? this.formatDateTime(obj.Date_Signed__c) : '',
                    "Intake Specialist" : obj.Intake_Specialist__c,
                    "Call Outcome" : obj.Call_Outcome__c,
                    "Contacting Consent" : obj.Contacting_Consent__c,
                    "Caller Recorded Consent" : obj.Caller_Recorded_Consent__c,
                    "SSN" : obj.SSN__c,
                    "Address" : obj.Address,
                    "Legal Representation Affirmation" : obj?.Client_Information__r ? obj.Client_Information__r[0]?.Legal_Representation_Affirmation__c : '',
                    "Relation To Loved One" : obj?.Client_Information__r ? obj.Client_Information__r[0]?.Relation_To_Loved_One__c : '',
                    "Loved One Still Living" : obj?.Client_Information__r ? obj.Client_Information__r[0]?.Loved_One_Still_Living__c : '',
                    "Next of Kin" : obj?.Client_Information__r ? obj.Client_Information__r[0]?.Next_of_Kin__c : '',
                    "Death Certificate" : obj?.Client_Information__r ? obj.Client_Information__r[0]?.Death_Certificate__c : '',
                    "Date Of Passing" : obj?.Client_Information__r ? this.formatDateTime(obj.Client_Information__r[0]?.Date_Of_Passing__c) : '',
                    "State Of Passing" : obj?.Client_Information__r ? obj.Client_Information__r[0]?.State_Of_Passing__c : '',
                    "Cause Of Death" : obj?.Client_Information__r ? obj.Client_Information__r[0]?.Cause_Of_Death__c : '',
                    "Marital Status" : obj?.Client_Information__r ? obj.Client_Information__r[0]?.Marital_Status__c : '',
                    "Emergency Contact Name" : obj?.Client_Information__r ? obj.Client_Information__r[0]?.Emergency_Contact_Name__c : '',
                    "Emergency Contact Relationship" : obj?.Client_Information__r ? obj.Client_Information__r[0]?.Emergency_Contact_Relationship__c : '',
                    "Emergency Contact Phone" : obj?.Client_Information__r ? obj.Client_Information__r[0]?.Emergency_Contact_Phone__c : '',
                    "Preferred Communication Method" : obj?.Client_Information__r ? obj.Client_Information__r[0]?.Preferred_Communication_Method__c : '',
                    "Injured Name" : obj?.Client_Information__r ? obj.Client_Information__r[0]?.Injured_Name__c : '',
                    "Injured Gender" : obj?.Client_Information__r ? obj.Client_Information__r[0]?.Injured_Gender__c : '',
                    "Injured Date Of Birth" : obj?.Client_Information__r ? this.formatDateTime(obj.Client_Information__r[0]?.Injured_Date_Of_Birth__c) : '',
                    "Injured State" : obj?.Client_Information__r ? obj.Client_Information__r[0]?.Injured_State__c : '',
                    "United States Resident" : obj?.Client_Information__r ? obj.Client_Information__r[0]?.United_States_Resident__c : '',
                    "Birth Weight" : obj?.Medical_Information__r ? obj.Medical_Information__r[0]?.Birth_Weight__c : '',
                    "Pregnancy Week At Birth" : obj?.Medical_Information__r ? obj.Medical_Information__r[0]?.Pregnancy_Week_At_Birth__c : '',
                    "Diagnosed In Hospital" : obj?.Medical_Information__r ? obj.Medical_Information__r[0]?.Diagnosed_in_Hospital__c : '',
                    "Diagnosis Facility" : obj?.Medical_Information__r ? obj.Medical_Information__r[0]?.Diagnosis_Facility__c : '',
                    "Birth Hospital" : obj?.Medical_Information__r ? obj.Medical_Information__r[0]?.Birth_Hospital__c : '',
                    "NEC Primary Symptom" : obj?.Medical_Information__r ? obj.Medical_Information__r[0]?.NEC_Primary_Symptom__c : '',
                    "NEC Secondary Symptom" : obj?.Medical_Information__r ? obj.Medical_Information__r[0]?.NEC_Secondary_Symptom__c : '',
                    "NEC Tertiary Symptom" : obj?.Medical_Information__r ? obj.Medical_Information__r[0]?.NEC_Tertiary_Symptom__c : '',
                    "Formula Fed In Hospital" : obj?.Medical_Information__r ? obj.Medical_Information__r[0]?.Formula_Fed_In_Hospital__c : '',
                    "NEC After Formula" : obj?.Medical_Information__r ? obj.Medical_Information__r[0]?.NEC_After_Formula__c : '',
                    "Current Child Condition" : obj?.Medical_Information__r ? obj.Medical_Information__r[0]?.Current_Child_Condition__c : '',
                    "NEC Treatments" : obj?.Medical_Information__r ? obj.Medical_Information__r[0]?.NEC_Treatments__c : '',
                    "Abdominal Surgeries" : obj?.Medical_Information__r ? obj.Medical_Information__r[0]?.Abdominal_Surgeries__c : '',
                    "Mother Name" : obj?.Medical_Information__r ? obj.Medical_Information__r[0]?.Mother_Name__c : '',
                    "Father Name" : obj?.Medical_Information__r ? obj.Medical_Information__r[0]?.Father_Name__c : '',
                    "Custody Parenting Issues" : obj?.Medical_Information__r ? obj.Medical_Information__r[0]?.Custody_Parenting_Issues__c : '',
                    "Custody Issues Description" : obj?.Medical_Information__r ? obj.Medical_Information__r[0]?.Custody_Issues_Description__c : '',
                    "Pregnancy Issues" : obj?.Medical_Information__r ? obj.Medical_Information__r[0]?.Pregnancy_Issues__c : '',
                    "Pregnancy Issues Description" : obj?.Medical_Information__r ? obj.Medical_Information__r[0]?.Pregnancy_Issues_Description__c : '',
                    "NICU Stay" : obj?.Medical_Information__r ? obj.Medical_Information__r[0]?.NICU_Stay__c : '',
                    "NICU Approx Dates" : obj?.Medical_Information__r ? obj.Medical_Information__r[0]?.NICU_Approx_Dates__c : '',
                    "NEC Diagnosis" : obj?.Medical_Information__r ? obj.Medical_Information__r[0]?.NEC_Diagnosis__c : '',
                    "Diagnosis Date" : obj?.Medical_Information__r ? this.formatDateTime(obj.Medical_Information__r[0]?.Diagnosis_Date__c) : ''
                  }))
            }
        } catch (error) {
            console.error('Error fetching data:', error);
            console.log('Error fetching data:', error);
            return null;
        }
    }


    get _fileName() {
        return this.fileName?.includes(".xlsx") ? this.fileName : `${this.fileName}.xlsx`;
    }

    exportToExcel() {
        const workbook = XLSX.utils.book_new();
        const headers = Object.keys(this.excelData[0]);
        const firstColumn = Object.keys(this.excelData[1]);
        const worksheetData = this.excelData;

        const worksheet = XLSX.utils.json_to_sheet(worksheetData, { header: headers });

        XLSX.utils.book_append_sheet(workbook, worksheet, this._fileName);

        worksheet['!autofilter'] = { ref: "A1:BJ1" };


        var wscols = [];
        for (var i = 0; i < firstColumn.length; i++) {  // columns length added
          wscols.push({ wch: firstColumn[i].length + 15 })
        }
        worksheet['!cols'] = wscols;

        const excelBuffer = XLSX.write(workbook, { bookType: "xlsx", type: "array" });
        const blob = new Blob([excelBuffer], { type: "application/octet-stream" });

        const a = document.createElement("a");
        a.href = URL.createObjectURL(blob);
        a.download = this._fileName;
        a.click();
        // Release the object URL to free up memory
        URL.revokeObjectURL(a.href);
    }
}