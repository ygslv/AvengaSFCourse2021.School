@isTest
private class ScholarshipRateBatchTest {

    @TestSetup
    static void setup() {
        
        List<Student__c> students = new List<Student__c>();

        for (Integer i = 0; i < 200; i++) {
            
            if ( i < 50) {

                students.add(new Student__c(
                Name = 'TestName' + i, Scholarship__c = 'Unassigned'
            ));
            } 
            else if ( i < 100 && i > 50) {

                students.add(new Student__c(
                Name = 'TestName' + i, Scholarship__c = 'Regular'
            ));
            }
            else if ( i < 150 && i > 100) {

                students.add(new Student__c(
                Name = 'TestName' + i, Scholarship__c = 'Increased'
            ));
            }
            else if ( i < 200 && i > 150) {

                students.add(new Student__c(
                Name = 'TestName' + i, Scholarship__c = 'Academic'
            ));
            }
        }

        insert students;
    }

    @isTest
    public static void testScholarshipRateBatch() {

        Test.startTest();
            ScholarshipRateBatch ba = new ScholarshipRateBatch();
            Id batchId = Database.executeBatch(ba);
        Test.stopTest(); 

        List<Student__c> studentsToCheck = [SELECT Name, Scholarship_Rate__c FROM Student__c];

        System.debug(studentsToCheck);

        for (Student__c s : studentsToCheck) {

            if ( s.Name == 'TestName15' ) { System.assertEquals(0, s.Scholarship_Rate__c); }
            else if ( s.Name == 'TestName52' ) { System.assertEquals(100, s.Scholarship_Rate__c); }
            else if ( s.Name == 'TestName111' ) { System.assertEquals(125, s.Scholarship_Rate__c); }
            else if ( s.Name == 'TestName178' ) { System.assertEquals(150, s.Scholarship_Rate__c); }
        }
    }
}