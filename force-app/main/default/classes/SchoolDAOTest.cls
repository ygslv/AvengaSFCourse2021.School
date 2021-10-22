@isTest
private class SchoolDAOTest {
    
    @testSetup
    static void setup() {

        List<Student__c> testStudents = new List<Student__c>();
        List<Class__c> testClasses = new List<Class__c>();

        // Creation of 5 classes and 5 students
        for(Integer i = 0; i < 5; i++) {

            testStudents.add(new Student__c(Name = ('TestStudent' + (i+1)), Year_of_Study__c = '1', Average_Grade__c = (i+1) * 10));
            testClasses.add(new Class__c(Year_of_Study__c = '1'));
        }

        insert testStudents;        
        insert testClasses;
    }

    @isTest
    static void testGetStudentPerformance() {

        Map<Id, Student__c> studentNames = new Map<Id, Student__c>([SELECT Name FROM Student__c]);

        Test.startTest();
        Map<Id, Decimal> studentPerformance = SchoolDAO.getStudentPerformance(studentNames.keySet());
        Test.stopTest();

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

    @isTest
    static void testGetClassAttendance() {

        List<Class__c> classes = [SELECT Id FROM Class__c];
        List<Student__c> students = [SELECT Id FROM Student__c];

        insert new Class_Enrollment__c(Class__c = classes[0].Id, Student__c = students[0].Id);
        insert new Class_Enrollment__c(Class__c = classes[0].Id, Student__c = students[1].Id);
        
        Test.startTest();
        Map<Id, Integer> classAttendance = SchoolDAO.getClassAttendance();
        Test.stopTest();

        System.assertEquals(2, classAttendance.get(classes[0].Id));
    }

    @isTest
    static void testGetTopStudents() {

        List<Class__c> classes = [SELECT Id FROM Class__c];
        List<Student__c> students = [SELECT Id FROM Student__c];

        insert new Class_Enrollment__c(Class__c = classes[0].Id, Student__c = students[0].Id);
        insert new Class_Enrollment__c(Class__c = classes[0].Id, Student__c = students[1].Id);

        Test.startTest();
        List<Class_Enrollment__c> topStudents = SchoolDAO.GetTopStudents(classes[0].Id);
        Test.stopTest();

        System.assertEquals(students[0].Id, topStudents[0].Student__c);
        System.assertEquals(students[1].Id, topStudents[1].Student__c);
    }

    @isTest
    static void testGetStudentsWithScholarship() {
        
        List<Class__c> classes = [SELECT Id FROM Class__c];

        insert new Student__c(Name = 'TestScholarship', Scholarship__c = 'Increased', Year_Of_Study__c = '1');

        List<Student__c> students = [SELECT Id FROM Student__c];
        
        insert new Class_Enrollment__c(Class__c = classes[0].Id, Student__c = [SELECT Id FROM Student__c WHERE Scholarship__c = 'Increased' LIMIT 1].Id);
        insert new Class_Enrollment__c(Class__c = classes[0].Id, Student__c = [SELECT Id FROM Student__c WHERE Scholarship__c = NULL LIMIT 1].Id);

        Test.startTest();
        Id studentWithScholarshipReturnId = SchoolDAO.GetStudentsWithScholarship(classes[0].Id)[0].Id;
        Test.stopTest();

        System.assertEquals('TestScholarship', [SELECT Name FROM Student__c WHERE Id = :studentWithScholarshipReturnId LIMIT 1].Name);
    }
}