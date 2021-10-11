public class SchoolService {
    
    public static void enrollStudentToClass(Id classId, Id studentId) {

        insert new class_Enrollment__c(Class__c = classId, Student__c = studentId);
    }
}
