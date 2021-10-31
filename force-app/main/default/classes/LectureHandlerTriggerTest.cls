@isTest
private class LectureHandlerTriggerTest {
    
    @isTest
    public static void testAddEndDate() {

        Test.startTest();
        insert new Lecture__c(
            Start_Date__c = datetime.newInstance(2021, 1, 1, 10, 30, 0), 
            Lecture_Subject__c = 'Algebra', Lecturer__c = 'TestLecturere1');

        Datetime lectureEndDatetime = [SELECT End_Date__c FROM Lecture__c].End_Date__c;

        Datetime datetimeToCheck = datetime.newInstance(2021, 1, 1, 12, 0, 0);
        Test.stopTest();

        System.assertEquals(datetimeToCheck, lectureEndDatetime);
    }
}
