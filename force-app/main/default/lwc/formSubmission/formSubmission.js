import { LightningElement, api, track } from 'lwc';
import getFormQuestions from '@salesforce/apex/FormMetadataController.getFormQuestions';
import saveFormAnswers from '@salesforce/apex/FormsController.saveFormAnswers';

import ToastContainer from 'lightning/toastContainer';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class FormSubmission extends LightningElement {
    @api formName;

    @track questions = [];
    @track sections = [];
    @track answers = {};

    isLoading = true;

    connectedCallback() {
        const toastContainer = ToastContainer.instance();
        toastContainer.toastPosition = 'top';

        console.log('window.location.href:', window.location.href);
        let urlString = window.location.href;
        let paramString = urlString.split("?")[1];
        let queryString = new URLSearchParams(paramString);

        for (let pair of queryString.entries()) {
          this.formName = decodeURIComponent(pair[1]);
        }
        console.log('this.formName', this.formName);
        this.fetchQuestions();
    }

    async fetchQuestions() {
        this.isLoading = true; 
        try {
            const result = await getFormQuestions({ formName: this.formName });
            console.log('Fetched result:', result); 
            console.log('this.formName', this.formName); // Log the fetched result

            this.questions = result.map(section  => {
                console.log('Section:', section); // Log each section
                const questions = section.questions.map(question => {
                    console.log('Question:', question); // Log each question
                    console.log('Question type:', question.type); 
                    return {
                        ...question,
                        isText: this.isTextField(question.type),
                        isPicklist: this.isDropdownField(question.type),
                        isDate: this.isDateField(question.type),
                        options: question.type === 'picklist' ? this.getOptions(question) : [],
                    };
                });
                return {
                    sectionTitle: section.sectionTitle, // Keep the section title
                    questions: questions // Processed questions with additional property
                };
            });
        } catch (error) {
            console.error('Error fetching questions:', error);
            console.error('e.message => ' + error.message );
            this.sections = [];
        } finally {
            this.isLoading = false;
        }
    }
    
    getOptions(question) {
        // Check if options are a single string and split it, otherwise use it directly as an array
        console.log(' question.options:', question.options); 
        console.log('typeof question.options:', typeof question.options); 
        typeof question.options
        const optionArray = typeof question.options === 'string' ? question.options.split(',') : question.options;
    
        // Map each option to the format { label: option, value: option }
        return optionArray.map(option => ({
            label: option.trim(),  // Trim any extra spaces
            value: option.trim()
        }));
    }

    handleInputChange(event) {
        const fieldApiName = event.target.dataset.fieldApiName;
        console.log('fieldApiName:', fieldApiName);  // Log to check if it's being set correctly
        if (fieldApiName) {
            this.answers[fieldApiName] = event.target.value;
        } else {
            console.warn("fieldApiName is missing on input element");
        }
    }

    handleSubmit() {
    // Check if all required fields are filled
    const requiredFields = Object.keys(this.answers).filter(key => {
        const question = this.questions.find(q => q.fieldApiName === key);
        return question.required && !this.answers[key];
    });

    if (requiredFields.length > 0) {
        // Display an error or message if there are missing required fields
        console.error('Please fill in all required fields.');
        return;
    }

    // Call Apex method to save answers

    this.isLoading = true; 
    

    saveFormAnswers({ formData: this.answers })
        .then(() => {
            // Show success message and reset form
            this.showToast('Success', 'Form submitted successfully!', 'success');
            setTimeout(() => window.location.reload(), 1000);
        })
        .catch(error => {
            let errorMessage = 'Failed to submit form.';
    
            if (error.body && error.body.pageErrors && error.body.pageErrors.length > 0) {
                errorMessage += ' ' + error.body.pageErrors.map(err => err.message).join('; ');
            } else if (error.body && error.body.fieldErrors) {
                // Loop through field-specific errors
                const fieldErrors = Object.keys(error.body.fieldErrors)
                    .map(field => `${field}: ${error.body.fieldErrors[field].map(err => err.message).join('; ')}`)
                    .join('; ');
                errorMessage += ' ' + fieldErrors;
            } else if (error.body && error.body.message) {
                errorMessage += ' ' + error.body.message;
            }

            this.showToast('Error', errorMessage, 'error');
        });
    }

    isTextField(fieldType) {
        return fieldType === 'text';
    }

    isDropdownField(fieldType) {
        return fieldType === 'picklist';
    }

    isDateField(fieldType) {
        return fieldType === 'date';
    }

    showToast(title, message, variant) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(evt);
    }

    /*@wire(CurrentPageReference)
    getPageReference(pageRef) {
        this.currentPageReference = pageRef;
        console.log('pageRef' + pageRef);
        console.log('pageRef.state. ' + pageRef.state);
        if (pageRef && pageRef.state.formName) {
            this.formName = pageRef.state.formName; // Retrieve formId from URL state
        } else {
            console.warn('formName is undefined'); // Log a warning if undefined
        }
    }*/
}