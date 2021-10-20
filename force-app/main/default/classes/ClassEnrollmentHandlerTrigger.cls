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

        Map<Id, Id> correspondingClassesAndStudents = new Map<Id, Id>();

        Map<Id, Class_Enrollment__c> existentClassEnrollments = new Map<Id, Class_Enrollment__c>(
            [SELECT 
                Class__c, Student__c
            FROM 
                Class_Enrollment__c
            ]);

        for (Class_Enrollment__c classEnrollment : classEnrollments) {

            if (correspondingClassesAndStudents.get(classEnrollment.Class__c) == NULL) {
                
                correspondingClassesAndStudents.put(classEnrollment.Class__c, classEnrollment.Student__c);
            } 
            else {

                classEnrollment.addError('Such a student already exists in such a class');
            }
        }

        for(Integer i = 0; i < classEnrollments.size(); i++) {
            
            Id classClEn_i_Id = classEnrollments.get(i).Class__c.Id;
            Id studentStEn_i_Id = classEnrollments.get(i).Student__c.Id;
            
            for(integer j = (i + 1); j < (classEnrollments.size() - 1); j++) {

                Id classClEn_j_Id = classEnrollments.get(j).Class__c.Id;
                Id studentStEn_j_Id = classEnrollments.get(j).Student__c.Id;

                if(classClEn_i_Id == classClEn_j_Id && studentStEn_i_Id == studentStEn_j_Id) {
                    
                    classEnrollments.remove(j);  
            }
        }
        
        for (Id currentClassId : correspondingClassesAndStudents.keySet()){

            Id currentStudentId = correspondingClassesAndStudents.get(currentClassId);

            if (existentClassEnrollments.get(currentClassId) != NULL && existentClassEnrollments.get(currentStudentId) != NULL) {
                
                classEnrollment.addError('Such a student already exists in such a class');
            }
        }
    }
}
