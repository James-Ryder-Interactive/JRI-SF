import { LightningElement, wire, track } from 'lwc';
import getForms from '@salesforce/apex/FormsController.getForms'; // Apex method to fetch form data
import getFormQuestions from '@salesforce/apex/FormMetadataController.getFormQuestions';

import { NavigationMixin } from 'lightning/navigation';

export default class FormsDashboard extends NavigationMixin(LightningElement) {
    @track forms = []; // Store form records
    @track countLabel;
    @track error; // Store any errors
    @track selectedFormId = null; // Track the selected form ID

    @track forms = [];

    // Fetch forms on component load
    connectedCallback() {
        this.loadForms();
    }
    
    // Method to fetch forms data
    loadForms() {
        getForms()
            .then(data => {
                this.forms = data;
                this.error = undefined;
            })
            .catch(error => {
                this.error = error;
                this.forms = [];
            });
    }

    handleCardAction(event) {
        const formName = event.target.dataset.formName;
        console.log('Selected Form Name:', formName); // Log to verify the form name
        
        // Construct the public site URL with the form name as a parameter
        const publicPageUrl = 'https://jrinteractive--jripart.sandbox.my.site.com/FormSubmission/?c__formName=' + formName;
        
        window.open(publicPageUrl, '_blank');
    } catch (error) {
        console.error('Error during navigation:', error); // Log any navigation errors
    }

    // Handle search input
    handleSearch(event) {
        const searchKey = event.target.value.toLowerCase();
        if (searchKey) {
            this.forms = this.forms.filter(form =>
                form.Name.toLowerCase().includes(searchKey)
            );
        } else {
            this.loadForms(); // Reload all forms if search is cleared
        }
    }

    // Handle row actions like View, Edit, Delete
    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;

        switch (actionName) {
            case 'view':
                this.navigateToForm(row.Id);
                break;
            case 'edit':
                this.navigateToEditForm(row.Id);
                break;
            case 'delete':
                this.deleteForm(row.Id);
                break;
            default:
        }
    }

    // Method to navigate to form view
    navigateToForm(formId) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: formId,
                actionName: 'view'
            }
        });
    }

    // Method to navigate to form edit page
    navigateToEditForm(formId) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: formId,
                actionName: 'edit'
            }
        });
    }

    // Method to delete form (with Apex logic)
    deleteForm(formId) {
        // Call Apex to delete record and refresh list on success
    }

    // Handle new form creation
    handleNewForm() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Form__c',
                actionName: 'new'
            }
        });
    }
}