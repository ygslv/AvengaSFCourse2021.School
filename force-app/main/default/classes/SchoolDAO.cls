public class SchoolDAO {

    public static Map<Id, Student__c> getStudentPerformance(Set<Id> studentIds) {

        Map<Id, Student__c> studentsAverageGrade = new Map<Id, Student__c>([SELECT Average_Grade__c, Id FROM Student__c WHERE Id IN :studentIds]);
        
        return studentsAverageGrade;
    }
}