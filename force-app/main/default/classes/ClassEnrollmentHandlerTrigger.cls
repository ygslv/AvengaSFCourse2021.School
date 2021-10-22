public class ClassEnrollmentHandlerTrigger {

    public static void handleInsertion(List<Class_Enrollment__c> ClassEnrollments) {

        // preventing creation Class Enrollment if the Student's Year of Study is not one of the Class's Year of Study.
        exceptionByYearOfStudy(ClassEnrollments);

        // preventing creation more than one Class Enrollment for the same Class and Student
        exceptionByDuplicateStudents(ClassEnrollments);
    }

    public static void exceptionByYearOfStudy(List<Class_Enrollment__c> classEnrollments){

        Map<Id, Class__c> classesByYearOfStudy = new Map<Id, Class__c>([SELECT Year_Of_Study__c FROM Class__c]);
        Map<Id, Student__c> studentsByYearOfStudy = new Map<Id, Student__c>([SELECT Year_Of_Study__c FROM Student__c]);

        for (Class_Enrollment__c triggerClassEnrollment : classEnrollments) {

            if (classesByYearOfStudy.get(triggerClassEnrollment.Class__c).Year_Of_Study__c != studentsByYearOfStudy.get(triggerClassEnrollment.Student__c).Year_Of_Study__c){
                
                triggerClassEnrollment.addError('Year of study field on the student record does not match with the year of study field on the class record');
            }
        }
    }

    public static void exceptionByDuplicateStudents(List<Class_Enrollment__c> classEnrollments){

        Set<Class_Enrollment__c> myset = new Set<Class_Enrollment__c>();
        List<Class_Enrollment__c> classEnrollmentsNoDuplicates = new List<Class_Enrollment__c>();

        Map<Id, Class_Enrollment__c> existentClassEnrollments = new Map<Id, Class_Enrollment__c>(
            [SELECT 
                Class__c, Student__c
            FROM 
                Class_Enrollment__c
            ]);
        
        // Remove duplicates from insertion list (Trigger.new)
        // Add Error about duplicates
        for (Class_Enrollment__c currentClassEnrollment : classEnrollments) {
            
            if (myset.add(currentClassEnrollment)) {

                classEnrollmentsNoDuplicates.add(currentClassEnrollment);
            }
            else {

                currentClassEnrollment.addError('Such a student already exists in the current insertion');
            }
        }
        
        for (Class_Enrollment__c currentClassEnrollment : classEnrollmentsNoDuplicates) {

            Id currentClassId = currentClassEnrollment.Class__c;
            Id currentStudentId = currentClassEnrollment.Student__c;

            for (Id existentClassEnrollmentId : existentClassEnrollments.keySet()) {
                
                Id existentClassId = existentClassEnrollments.get(existentClassEnrollmentId).Class__c;
                Id existentStudentId = existentClassEnrollments.get(existentClassEnrollmentId).Student__c;
                
                if (currentClassId == existentClassId && currentStudentId == existentStudentId){

                    currentClassEnrollment.addError('Such a student already exists in the such class');
                }
            }
        }
    }
}