@isTest
public class LectureToClassHandlerTriggerTest {
    
    @testSetup
    static void setup() {
        
        List<Lecture__c> testLectures = new List<Lecture__c>();
        List<Class__c> testClasses = new List<Class__c>();

        insert new Lecturer__c(Name = 'TestLecturer1');
        Id lecturerId = [SELECT Id FROM Lecturer__c].Id;

        for(Integer i = 0; i < 2; i++) {

            testLectures.add(new Lecture__c(Start_Date__c = datetime.newInstance(2024, 1, 1, 10, 30, 0), 
            Lecture_Subject__c = 'Algebra', Lecturer__c = lecturerId));
            testClasses.add(new Class__c(Year_of_Study__c = '1'));
        }

        insert testLectures;        
        insert testClasses;        
    }

    @isTest 
    static void testExceptionByDuplicateLectures() {

        List <Lecture__c> lectures = [SELECT Id FROM Lecture__c];
        List <Class__c> classes = [SELECT Id FROM Class__c];
    
        Boolean isFailed = false;
        
        try {
            
            Test.startTest();
            insert new Lecture_to_Class__c(Class__c = classes[0].Id, Lecture__c = lectures[0].Id);
            insert new Lecture_to_Class__c(Class__c = classes[0].Id, Lecture__c = lectures[0].Id);
            Test.stopTest();
        } 
        catch(DmlException e) {
    
            isFailed = true; 
        }
    
        System.assertEquals(true, isFailed);
    }
}
