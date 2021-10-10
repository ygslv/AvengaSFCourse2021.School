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

    public static List<Class_Enrollment__c> getTopStudents(Id classId){

        // Селект Студенів з Енролу
        // Перевірка на те, чи клас ІД = класу, який в інпуті
        // Сортування за оцінкою (DESC - від більшого до меншого)
        // Ліміт 10
        List<Class_Enrollment__c> topStudents = [SELECT Student__c FROM Class_Enrollment__c WHERE Class__r.Id = :classId ORDER BY Grade__c DESC LIMIT 10];

        return topStudents;
    }

    public static List<Student__c> getStudentsWithScholarship(Id classId){

        // Ініціалізація ліста в який будуть зберігатися кінцеві студенти
        List<Student__c> studentsWithScholarshipForSpecificClass = new List<Student__c>();

        // Кверяєм ВСІХ студентів з стипендією
        List<Student__c> studentsWithScholarship = [SELECT Id FROM Student__c WHERE Scholarship__c != 'Unassigned' AND Scholarship__c != NULL];

        // Кверяєм всі переведення студентів в класи
        Set<Class_Enrollment__c> classEnrollments = new Set<Class_Enrollment__c>([SELECT Class__r.Id, Student__r.Id FROM Class_Enrollment__c]);

        // Проходимось циклом по студентах з стипендією
        for (Student__c currentStudent : studentsWithScholarship){
            
            Id currentStudentId = currentStudent.Id;

            // Проходимось циклом по енролах (для перевіруи пари студент - клас)
            for (Class_Enrollment__c currentEnrollmet : classEnrollments){
            
                Id enrollmentClassId = currentEnrollmet.Class__r.Id;
                Id enrollmentStudentId = currentEnrollmet.Student__r.Id;

                // Якщо ідшки класу і студента сходяться з студентом якого перевіряєм
                // і класом, який заданий в інпуті - додаємо до порожнього ліста
                if (enrollmentClassId == classId && enrollmentStudentId == currentStudentId){
                    studentsWithScholarshipForSpecificClass.add(currentStudent);
                }
            }
        }

        return studentsWithScholarshipForSpecificClass;
    }
}