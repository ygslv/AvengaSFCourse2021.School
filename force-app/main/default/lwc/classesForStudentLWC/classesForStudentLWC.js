import { LightningElement, api, wire, track } from 'lwc';
import getClassesForCurrentStudent from '@salesforce/apex/YearOfStudyClassesLWCController.getClassesForCurrentStudent';

export default class classesForStudentLWC extends LightningElement {

    @api recordId; 

    @track error;
    @track classList;

    @track columns = [{
        label: 'Subject',
        fieldName: 'subject',
        type: 'text',
        sortable: true
    },
    {
        label: 'Year of study',
        fieldName: 'yearOfStudy',
        type: 'text',
        sortable: true
    }];

    @wire(getClassesForCurrentStudent, { studentId : '$recordId' }) foundClasses({
        error, data
    }) {
        if (data) {
            this.classList = data;
        } else if (error) {
            this.error = error;
        }
    }
}