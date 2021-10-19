@isTest
private class SchoolServiceTest {

    @testSetup static void setup() {
        
        List<Student__c> testStudents = new List<Student__c>();
        List<Class__c> testClasses = new List<Class__c>();

        for (Integer i = 0; i < 2; i++) {

            testStudents.add(new Student__c(Name = 'TSt' + i));
            testClasses.add(new Class__c(Year__c = '999' + i));
        }

        insert testStudents;
        insert testClasses;  
    }
    
    @isTest static void testEnrollStudentToClass() {
        
        Student__c st = [SELECT Id FROM Student__c WHERE Name = 'TSt0' LIMIT 1];
        Class__c cl = [SELECT Id FROM Class__c WHERE Year__c = '9990' LIMIT 1];

        SchoolService.enrollStudentToClass(cl.Id, st.Id);
    }

    // recalculateScholarship(Id studentId)
    // setAcademicScholarship(Id studentId)
    // setGrade(Id classEnrollmentId, Integer grade)
    // setGrade(Id classId, Id studentId, Integer grade)
    // enrollStudentToClass(Id classId, Id studentId)
}