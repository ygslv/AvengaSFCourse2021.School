public class ScholarshipRateBatch implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {

        String scholarshipQuery = 'SELECT Scholarship__c FROM Student__c';
        
        return Database.getQueryLocator( scholarshipQuery );
    }

    public void execute(Database.BatchableContext bc, List<Student__c> scope) {

        for (Student__c c : scope) {

            if (c.Scholarship__c == 'Unassigned' || c.Scholarship__c == NULL) { c.Scholarship_Rate__c = 0; }
            else if (c.Scholarship__c == 'Regular') { c.Scholarship_Rate__c = 100; }
            else if (c.Scholarship__c == 'Increased') { c.Scholarship_Rate__c = 125; }
            else if (c.Scholarship__c == 'Academic') { c.Scholarship_Rate__c = 150; }
        }

        update scope;
    }

    public void finish(Database.BatchableContext bc) {}
}
