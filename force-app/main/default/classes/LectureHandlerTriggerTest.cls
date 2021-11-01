@isTest
private class LectureHandlerTriggerTest {
    
    @isTest
    public static void testAddEndDate() {

        insert new Lecturer__c(Name = 'sdfsdfs');
        Id lecturerId = [SELECT Id FROM Lecturer__c LIMIT 1].Id;

        Test.startTest();
        insert new Lecture__c(
            Start_Date__c = datetime.newInstance(2024, 1, 1, 10, 30, 0), 
            Lecture_Subject__c = 'Algebra', Lecturer__c = lecturerId);

        Datetime lectureEndDatetime = [SELECT End_Date__c FROM Lecture__c].End_Date__c;

        Datetime datetimeToCheck = datetime.newInstance(2024, 1, 1, 12, 0, 0);
        Test.stopTest();

        System.assertEquals(datetimeToCheck, lectureEndDatetime);
    }
}