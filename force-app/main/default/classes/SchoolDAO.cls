public class SchoolDAO {

    public static Map<Id, Decimal> getStudentPerformance(Set<Id> studentIds) {

        // Ініціалізація мапки, для збереження ідшки і оцінки
        Map<Id, Decimal> studentAverageGrades = new Map<Id, Decimal>();    

        // Ініціалізація ліста, в який кверяєм значення ідшки і середньої оцінки для студентів, ідшки яких є в сеті
        List<Student__c> students = [SELECT Id, Average_Grade__c FROM Student__c WHERE Id IN :studentIds]; 

        // Цикл перевірки кожного студента з ліста
        for (Student__c st : students){
            studentAverageGrades.put(st.Id, st.Average_Grade__c); // put значень в порожню мапку
        }

        return studentAverageGrades;    
    }
}