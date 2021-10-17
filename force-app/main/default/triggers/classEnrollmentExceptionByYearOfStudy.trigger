
// Preventing creation Class Enrollment if the Student's Year of Study is not one of the Class's Year of Study.

trigger classEnrollmentExceptionByYearOfStudy on Class_Enrollment__c (before insert) {
    
    for (Class_Enrollment__c classEnrollment : Trigger.new){

        Class__c currentClass = [
            SELECT
                Year_Of_Study__c
            FROM
                Class__c
            WHERE 
                Id = :classEnrollment.Class__c   
        ];
                
        Student__c currentStudent = [
            SELECT
                Year_Of_Study__c
            FROM
                Student__c
            WHERE
                Id = :classEnrollment.Student__c
        ];
            
        if (currentClass.Year_Of_Study__c != currentStudent.Year_of_Study__c) {
            
            classEnrollment.addError('Year of study field on the student record does not match with the year of study field on the class record');
        }     
    }
}