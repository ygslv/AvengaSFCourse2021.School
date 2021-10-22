@isTest
private class ClassEnrollmentHandlerTriggerTest {
    
    @testSetup
    static void setup() {
        
        List<Student__c> testStudents = new List<Student__c>();
        List<Class__c> testClasses = new List<Class__c>();

        String yearOfStudy;

        // Creation of 5 classes and 5 students
        for(Integer i = 0; i < 5; i++) {

            yearOfStudy = string.valueof(i+1);

            testStudents.add(new Student__c(Name = ('TestStudent' + yearOfStudy), Year_of_Study__c = yearOfStudy));
            testClasses.add(new Class__c(Year_of_Study__c = yearOfStudy));
        }

        insert testStudents;        
        insert testClasses;        
    }

    @isTest static void exceptionByDuplicateStudents() {

        List <Student__c> students = [SELECT Id FROM Student__c];
        List <Class__c> classes = [SELECT Id FROM Class__c];

        Boolean isFailed = false;
        
        try {
            
            Test.startTest();
            insert new Class_Enrollment__c(Class__c = classes[0].Id, Student__c = students[0].Id);
            insert new Class_Enrollment__c(Class__c = classes[0].Id, Student__c = students[0].Id);
            Test.stopTest();
        } 
        catch(DmlException e) {

            isFailed = true; 
        }

        System.assertEquals(true, isFailed);
    }

    @isTest static void testExceptionByYearOfStudy() {

        List <Student__c> students = [SELECT Id FROM Student__c];
        List <Class__c> classes = [SELECT Id FROM Class__c];

        Boolean isFailed = false;

        try {

            Test.startTest();
            insert new Class_Enrollment__c(Class__c = classes[0].Id, Student__c = students[1].Id);
            Test.stopTest();
        } 
        catch(DmlException e) {

            isFailed = true;
        }

        System.assertEquals(true, isFailed);
    }
}
