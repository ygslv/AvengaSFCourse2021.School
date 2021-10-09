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

    public static Map<Id, Integer> getClassAttendance(){

        // Ініціалізація мапки, для збереження к-ті студентів в класі
        Map<Id, Integer> classAttendance = new Map<Id, Integer>(); 
        
        // Ініціалізація ліста, в який кверяєм значення ідшок класів в які переходили студенти
        List<Class_Enrollment__c> classEnrollments = [SELECT Class__r.Id FROM Class_Enrollment__c];

        for (Class_Enrollment__c currentClass : classEnrollments){
            
            // Ініціалізуємо змінну каррент класу, для зручності і лаконічності
            Id currentClassId = currentClass.Class__r.Id;

            // Якщо ключа, зі значенням ідшки немає в мапі, прирівнюю його до 1
            if (!classAttendance.containsKey(currentClassId)){
                classAttendance.put(currentClassId, 1);
            } else { // Якщо такий ключ є, через метод get витягую значення і збільшую на 1
                classAttendance.put(currentClassId, (classAttendance.get(currentClassId) + 1));
            }
        }

        return classAttendance;
    }
}

// Return map, where key = Class Id and value = how many students are attending this class.
// Don't use Number_of_Students__c field.