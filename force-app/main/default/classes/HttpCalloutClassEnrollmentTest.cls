@isTest
private class HttpCalloutClassEnrollmentTest {

    @TestSetup
    static void setup() {
        
        insert new Student__c( Name = 'TestName1', Year_of_Study__c = '1');
        insert new Class__c( Year_of_Study__c = '1');

        insert new Class_Enrollment__c( Student__c = [SELECT Id FROM Student__c LIMIT 1].Id, Class__c = [SELECT Id FROM Class__c LIMIT 1].Id );
    }

    @isTest static void testHttpCalloutClassEnrollment() {

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        Test.startTest();
        HttpResponse res = HttpCalloutClassEnrollment.HttpCalloutClassEnrollment([SELECT Id FROM Class_Enrollment__c LIMIT 1].Id);
        Test.stopTest();

        System.assertEquals(200, res.getStatusCode());
    }

    @isTest static void testHttpCalloutDeletingClassEnrollment_StatusCode200() {

        List <Class_Enrollment__c> classEnrollments = [SELECT Id FROM Class_Enrollment__c];

        Test.startTest();
        HttpCalloutClassEnrollment.HttpCalloutDeletingClassEnrollment(200, classEnrollments[0].Id);
        Test.stopTest();

        List <Class_Enrollment__c> classEnrollmentsToCheck = [SELECT Id FROM Class_Enrollment__c];

        System.assertEquals(0, classEnrollmentsToCheck.size());
    }
}