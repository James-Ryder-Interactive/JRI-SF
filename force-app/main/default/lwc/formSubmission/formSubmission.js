import { LightningElement, api, track } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import getFormQuestions from '@salesforce/apex/FormMetadataController.getFormQuestions';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class FormSubmission extends LightningElement {
    @api formName;

    @track questions = [];
    @track sections = [];
    @track answers = {};

    isLoading = true;

    connectedCallback() {
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
        if (fieldApiName) {
            this.answers[fieldApiName] = event.target.value;
        } else {
            console.warn("fieldApiName is missing on input element");
        }
    }

    handleSubmit() {
        submitForm({ formName: this.formName, answers: this.answers })
            .then(() => {
                // Show success message and reset form
                this.showToast('Success', 'Form submitted successfully!', 'success');
                this.answers = {};
            })
            .catch(error => {
                this.showToast('Error', 'Failed to submit form: ' + error.body.message, 'error');
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
            title,
            message,
            variant,
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