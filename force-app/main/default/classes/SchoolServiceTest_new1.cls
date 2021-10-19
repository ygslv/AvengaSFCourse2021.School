@isTest
private class SchoolServiceTest_new1 {

    @testSetup static void setup() {
        
       Student__c student = new Student__c();
       Class__c testClass = new Class__c();
        
       insert student;
       insert testClass;
    }
    
    
    
    @isTest
    static void testEnrollStudent() {
        
        Student__c student = [
            SELECT
                Id, Average_Grade__c, Scholarship__c
            FROM
                Student__c
        ];
        
        Class__c testClass = [
            SELECT
                Id
            FROM 
                Class__c
        ];
        
        SchoolService.enrollStudentToClass(testClass.Id, student.Id);
        
        SchoolService.setGrade(testClass.Id, student.Id, 3);
        
        List<Class_Enrollment__c> classEnrollments = [
            SELECT
                Id, Grade__c
            FROM
                Class_Enrollment__c
        ];
        
        SchoolService.setAcademicScholarship(student.Id);
        
        student.Average_Grade__c = 80;
        
        update student;
        
        SchoolService.recalculateScholarship(student.Id);
        
        System.assertEquals(1, classEnrollments.size());
        
        System.assertEquals(3, classEnrollments.get(0).Grade__c);
        
        System.assertEquals('Regular', student.Scholarship__c);
        
    }

    @isTest
    static void testEnrollStudentToClass(){
        
        Student__c student = [
            SELECT
                Id, Average_Grade__c, Scholarship__c
            FROM
                Student__c
        ];
        
        Class__c testClass = [
            SELECT
                Id
            FROM 
                Class__c
        ];

        List<Class_Enrollment__c> classEnrollments = [
            SELECT
                Id, Grade__c
            FROM
                Class_Enrollment__c
        ];

        SchoolService.enrollStudentToClass(testClass.Id, student.Id);

        System.assertEquals(1, classEnrollments.size());
    }

    @isTest
    static void setGrade(){

        Student__c student = [
            SELECT
                Id, Average_Grade__c, Scholarship__c
            FROM
                Student__c
        ];
        
        Class__c testClass = [
            SELECT
                Id
            FROM 
                Class__c
        ];

        List<Class_Enrollment__c> classEnrollments = [
            SELECT
                Id, Grade__c
            FROM
                Class_Enrollment__c
        ];

        SchoolService.setGrade(testClass.Id, student.Id, 3);

        System.assertEquals(3, classEnrollments.get(0).Grade__c);
    }
}