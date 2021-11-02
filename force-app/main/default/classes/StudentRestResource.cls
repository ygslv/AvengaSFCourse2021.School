@RestResource(urlMapping='/*')
global class StudentRestResource {
    
    @HttpGet
    global static List<Student__c> getTopStudents() {
        
        // return JSON.serialize(new List<Student__c>([SELECT Id, Name, Average_Grade__c FROM Student__c ORDER By Average_Grade__c ASC LIMIT 5]));
        return new List<Student__c>([SELECT Id, Name, Average_Grade__c FROM Student__c ORDER BY Average_Grade__c DESC NULLS LAST LIMIT 5]);
    }
}