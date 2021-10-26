public class StudentAuraController {
    
    @AuraEnabled
    public static List<Student__c> getStudentsWithScholarship(){

        List<Student__c> studentsWithScholarship = 
            ([SELECT 
                Scholarship__c, Name
            FROM 
                Student__c 
            WHERE 
                Scholarship__c != 'Unassigned' AND Scholarship__c != NULL]);

        return studentsWithScholarship;
    }
}