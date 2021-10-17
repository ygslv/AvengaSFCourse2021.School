
// Preventing creation more than one Class Enrollment for the same Class and Student.

trigger classEnrollmentExceptionByStudentInTheSameClass on Class_Enrollment__c (before insert) {

    for (Class_Enrollment__c classEnrollment : Trigger.new){

        if (![SELECT Class__c, Student__c FROM Class_Enrollment__c WHERE Class__c = :classEnrollment.Class__c AND Student__c = :classEnrollment.Student__c].isEmpty()) {
            classEnrollment.addError('Such a student already exists in such a class');
        }   
    }
}