@isTest
private class SchoolServiceTest {
    
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

    @isTest static void testEnrollStudentToClass_ExceptionByDuplicates() {
        
        List <Student__c> students = [SELECT Id FROM Student__c];
        List <Class__c> classes = [SELECT Id FROM Class__c];

        Boolean isFailed = false;
        
        try {
            
            SchoolService.enrollStudentToClass(classes[0].Id, students[0].Id);
            SchoolService.enrollStudentToClass(classes[0].Id, students[0].Id);
        } 
        catch(DmlException e) {

            isFailed = true; 
            System.assert(e.getMessage().contains('Such a student already exists in the such class'));
        }

        System.assertEquals(true, isFailed);
    }

    @isTest static void testEnrollStudentToClass() {
        
        List <Student__c> students = [SELECT Id FROM Student__c];
        List <Class__c> classes = [SELECT Id FROM Class__c];
        List <Class_Enrollment__c> enrollmentIds = new List <Class_Enrollment__c>();
        
        for (Integer i = 0; i < students.size(); i++) {

            SchoolService.enrollStudentToClass(classes[i].Id, students[i].Id);
        }

        enrollmentIds = [SELECT Id FROM Class_Enrollment__c];

        System.assertEquals(5, enrollmentIds.size());
    }

    @isTest static void testEnrollStudentToClass_ExceptionByYearOfStudy() {
        
        List <Student__c> students = [SELECT Id FROM Student__c];
        List <Class__c> classes = [SELECT Id FROM Class__c];
        
        Boolean isFailed = false;

        try {
            
            SchoolService.enrollStudentToClass(classes[0].Id, students[1].Id);
        } 
        catch(DmlException e) {

            isFailed = true;
            System.assert(e.getMessage().contains('Year of study field on the student record does not match with the year of study field on the class record'));
        }

        System.assertEquals(true, isFailed);
    }

    @isTest static void testSetGrade_ByStudentAndClassIds() {

        List <Student__c> students = [SELECT Id FROM Student__c];
        List <Class__c> classes = [SELECT Id FROM Class__c];

        Integer classEnrollmentGrade;

        insert new class_Enrollment__c(Class__c = classes[0].Id, Student__c = students[0].Id);

        SchoolService.setGrade(classes[0].Id, students[0].Id, 20);

        classEnrollmentGrade = integer.valueof([SELECT Grade__c FROM Class_Enrollment__c WHERE Class__r.Id = :classes[0].Id AND Student__r.Id = :students[0].Id].Grade__c);
        
        System.assertEquals(20, classEnrollmentGrade);
    }

    @isTest static void testSetGrade_ByClassEnrollmentId() {

        List <Student__c> students = [SELECT Id FROM Student__c];
        List <Class__c> classes = [SELECT Id FROM Class__c];
        
        Integer classEnrollmentGrade;
        Id classEnrollmentId;

        insert new class_Enrollment__c(Class__c = classes[0].Id, Student__c = students[0].Id);

        classEnrollmentId = [SELECT Id FROM Class_Enrollment__c].Id;

        SchoolService.setGrade(classEnrollmentId, 50);

        classEnrollmentGrade = integer.valueof([SELECT Grade__c FROM Class_Enrollment__c WHERE Id = :classEnrollmentId].Grade__c);
        
        System.assertEquals(50, classEnrollmentGrade);
    }

    @isTest static void testSetAcademicScholarship() {

        List <Student__c> students = [SELECT Id FROM Student__c];
        
        SchoolService.setAcademicScholarship(students[1].Id);
        
        String studentScholarship = string.valueof([SELECT Scholarship__c FROM Student__c WHERE Id = :students[1].Id].Scholarship__c);
        
        System.assertEquals('Academic', studentScholarship);
    }

    @isTest static void testRecalculateScholarship_Increased() {

        List <Student__c> students = [SELECT Id FROM Student__c];
        List <Class__c> classes = new List <Class__c>();
        
        String studentScholarship;

        classes = [SELECT Id FROM Class__c WHERE Year_of_Study__c = '1'];

        insert new Class_Enrollment__c(Class__c = classes[0].Id, Student__c = students[0].Id, Grade__c = 100);

        Test.startTest();
        SchoolService.recalculateScholarship(students[0].Id);
        Test.stopTest();
        
        studentScholarship = string.valueof([SELECT Scholarship__c FROM Student__c WHERE Id = :students[0].Id].Scholarship__c);

        System.assertEquals('Increased', studentScholarship); 
    }

    @isTest static void testRecalculateScholarship_Regular() {

        List <Student__c> students = [SELECT Id FROM Student__c];
        List <Class__c> classes = new List <Class__c>();
        
        String studentScholarship;

        classes = [SELECT Id FROM Class__c WHERE Year_of_Study__c = '1'];

        insert new Class_Enrollment__c(Class__c = classes[0].Id, Student__c = students[0].Id, Grade__c = 75);

        Test.startTest();
        SchoolService.recalculateScholarship(students[0].Id);
        Test.stopTest();
        
        studentScholarship = string.valueof([SELECT Scholarship__c FROM Student__c WHERE Id = :students[0].Id].Scholarship__c);

        System.assertEquals('Regular', studentScholarship); 
    }

    @isTest static void testRecalculateScholarship_Unassigned() {

        List <Student__c> students = [SELECT Id FROM Student__c];
        List <Class__c> classes = new List <Class__c>();
        
        String studentScholarship;

        classes = [SELECT Id FROM Class__c WHERE Year_of_Study__c = '1'];

        insert new Class_Enrollment__c(Class__c = classes[0].Id, Student__c = students[0].Id, Grade__c = 30);

        Test.startTest();
        SchoolService.recalculateScholarship(students[0].Id);
        Test.stopTest();
        
        studentScholarship = string.valueof([SELECT Scholarship__c FROM Student__c WHERE Id = :students[0].Id].Scholarship__c);

        System.assertEquals('Unassigned', studentScholarship); 
    }
}
