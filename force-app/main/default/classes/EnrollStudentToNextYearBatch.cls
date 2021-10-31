public class EnrollStudentToNextYearBatch implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {

        String scholarshipQuery = 'SELECT Year_of_Study__c FROM Student__c';
        
        return Database.getQueryLocator( scholarshipQuery );
    }

    public void execute(Database.BatchableContext bc, List<Student__c> scope) {

        for (Student__c c : scope) {

            if (c.Year_of_Study__c == '5') {
                
                releaseStudentFromSchool(c);
            }
            else {

                c.Year_of_Study__c = string.valueof(integer.valueof(c.Year_of_Study__c) + 1);
            }
        }

        update scope;
    }

    public void finish(Database.BatchableContext bc) {


    }

    public void releaseStudentFromSchool (Student__c student) {

        student.Status__c = 'Graduated';

        update student;  
    }
}
