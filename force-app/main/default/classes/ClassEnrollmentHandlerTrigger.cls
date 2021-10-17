public class ClassEnrollmentHandlerTrigger {

    public static void handleInsertion(List<Class_Enrollment__c> ClassEnrollments) {

        // preventing creation Class Enrollment if the Student's Year of Study is not one of the Class's Year of Study.
        exceptionByYearOfStudy(ClassEnrollments);

        // preventing creation more than one Class Enrollment for the same Class and Student
        exceptionByDuplicateStudents(ClassEnrollments);
    }

    public static void exceptionByYearOfStudy(List<Class_Enrollment__c> ClassEnrollments){

        for (Class_Enrollment__c classEnrollment : ClassEnrollments){

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

    public static void exceptionByDuplicateStudents(List<Class_Enrollment__c> ClassEnrollments){
        
        for (Class_Enrollment__c classEnrollment : ClassEnrollments){

            if (![SELECT Class__c, Student__c FROM Class_Enrollment__c WHERE Class__c = :classEnrollment.Class__c AND Student__c = :classEnrollment.Student__c].isEmpty()) {
                classEnrollment.addError('Such a student already exists in such a class');
            }   
        }
    }
}
