@isTest
private class StudentAuraControllerTest {
    
    @testSetup
    static void setup() {
        
        List<Student__c> testStudents = new List<Student__c>();

        testStudents.add(new Student__c(Name = 'TestStudent1', Scholarship__c = 'Unassigned'));
        testStudents.add(new Student__c(Name = 'TestStudent2', Scholarship__c = 'Regular'));
        testStudents.add(new Student__c(Name = 'TestStudent3', Scholarship__c = 'Increased'));
        testStudents.add(new Student__c(Name = 'TestStudent4'));

        insert testStudents;        
    }

    @isTest
    static void testGetStudentsWithScholarship() {

        Test.startTest();
        List<Student__c> studentsWithScholarship = StudentAuraController.getStudentsWithScholarship();
        Test.stopTest();

        System.assertEquals(2, studentsWithScholarship.size());

        for (Student__c currentStudent : studentsWithScholarship) {

            if (currentStudent.Name == 'TestStudent2') {

                System.assertEquals('Regular', currentStudent.Scholarship__c);
            }
            else if (currentStudent.Name == 'TestStudent3') {

                System.assertEquals('Increased', currentStudent.Scholarship__c);
            }
        }      
    }
}