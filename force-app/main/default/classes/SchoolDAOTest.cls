@isTest
private class SchoolDAOTest {
    
    @testSetup
    static void setup() {

        List<Student__c> testStudents = new List<Student__c>();
        List<Class__c> testClasses = new List<Class__c>();

        String yearOfStudy;

        // Creation of 5 classes and 5 students
        for(Integer i = 0; i < 5; i++) {

            testStudents.add(new Student__c(Name = ('TestStudent' + (i+1)), Average_Grade__c = (i+1) * 10));
            //testClasses.add(new Class__c(Year_of_Study__c = i));
        }

        insert testStudents;        
        insert testClasses;
    }

    @isTest
    static void testGetStudentPerformance() {

        Map<Id, Student__c> studentNames = new Map<Id, Student__c>([SELECT Name FROM Student__c]);
        Map<Id, Decimal> studentPerformance = SchoolDAO.getStudentPerformance(studentNames.keySet());

        for (Id studentId : studentNames.keySet()) {

            if (studentNames.get(studentId).Name == 'TestStudent1') {

                System.assertEquals(10, studentPerformance.get(studentId));
            }
            else if (studentNames.get(studentId).Name == 'TestStudent2') {

                System.assertEquals(20, studentPerformance.get(studentId));
            } 
            else if (studentNames.get(studentId).Name == 'TestStudent5') {
                System.assertEquals(50, studentPerformance.get(studentId));
            }
        }
    }
}
