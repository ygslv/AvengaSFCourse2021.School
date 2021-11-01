import { LightningElement, api, wire, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import  HttpCalloutDeletingClassEnrollment  from '@salesforce/apex/HttpCalloutClassEnrollment.HttpCalloutDeletingClassEnrollment';


export default class DeletingClassEnrollmentButtonLWCComponent extends NavigationMixin(LightningElement) {

    @api recordId;

    handleClick(){

        HttpCalloutDeletingClassEnrollment({classEnrollmentId : this.recordId})
        .then(() => {
            this.showToast('Success', 'The record has been deleted successfully!', 'Success');
            this.navigateToListView();
        })
        .catch(error => {
            this.showToast('Error', 'There was an error deleting a record' + error.body.message , 'Error');
        })
        
    } 

    showToast(title, message, variant) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(evt);
    }

    navigateToListView() {
        // Navigate to the Contact object's Recent list view.
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Class_Enrollment__c',
                actionName: 'list'
            },
        });
    }
}