import { LightningElement, api, wire, track } from 'lwc';
import getStudentsForCurrentClass from '@salesforce/apex/StudentsInClassLWCComponent.getStudentsForCurrentClass';

export default class StudentsInClassLWCComponent extends LightningElement {

    @api recordId; 

    @track error;
    @track stList;

    columns = [{
        label: 'Student name',
        fieldName: 'studentName',
        type: 'text',
        sortable: true
    },
    {
        label: 'Grade',
        fieldName: 'grade',
        type: 'text',
        sortable: true
    }];

    @wire(getStudentsForCurrentClass, { classId : '$recordId' }) foundStudents({
        error, data
    }) {
        if (data) {
            this.stList = data;
        } else if (error) {
            this.error = error;
        }
    }
}