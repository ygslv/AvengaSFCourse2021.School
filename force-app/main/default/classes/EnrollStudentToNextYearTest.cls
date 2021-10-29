@isTest
private class EnrollStudentToNextYearTest {
    
    @TestSetup
    static void setup() {

        List <Student__c> testStudents = new List <Student__c>();

        for (Integer i = 0; i < 5; i++) {

            String yearOfStudy = string.valueof(i+1);

            testStudents.add(new Student__c(Name = ('TestStudent' + yearOfStudy), Year_of_Study__c = yearOfStudy));
        }

        insert testStudents;
    }

    @isTest
    public static void testSchedule() {

        String cronString = '0 0 0 15 JUN ? 2022/1'; // At 00:00:00am, on the 15th day, in June, starting in 2022

        Test.startTest();
            String JobId = System.schedule(
            'Changing Year Of Study In Summer', 
            cronString, 
            new EnrollStudentToNextYearInSummer());
        Test.stopTest();

        CronTrigger ct = [SELECT Id FROM CronTrigger WHERE CronJobDetail.Name = 'Changing Year Of Study In Summer'];
       	
        System.assertNotEquals(ct, null);
    }

    @isTest
    public static void testBatch() {

        Test.startTest();
            Id batchId = Database.executeBatch(new EnrollStudentToNextYearBatch());
        Test.stopTest(); 

        List<Student__c> studentsToCheck = [SELECT Name, Year_of_Study__c FROM Student__c];

        for (Student__c c : studentsToCheck) {

            if (c.Name == 'TestStudent1') { System.assertEquals('2', c.Year_of_Study__c); }
            else if (c.Name == 'TestStudent4') { System.assertEquals('5', c.Year_of_Study__c); }
            else if (c.Name == 'TestStudent5') { System.assertEquals('5', c.Year_of_Study__c); }
        }
    }
}