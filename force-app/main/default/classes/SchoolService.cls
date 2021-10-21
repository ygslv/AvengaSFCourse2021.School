public class SchoolService {
    
    public static void enrollStudentToClass(Id classId, Id studentId) {

        // Create class enrollment for given class and student.
        insert new class_Enrollment__c(Class__c = classId, Student__c = studentId);
    }

    public static void enrollStudentsToClass(List<List<Id>> classIdToStudentId) {

        // Create class enrollments for given classes and students. (bulk)
        
        List<Class_Enrollment__c> classEnrollments = new List<Class_Enrollment__c>();

        for (List<Id> listOfIds : classIdToStudentId) {

            Id classId = listOfIds[0]; // Class ID as first argument
            Id stundetId = listOfIds[1]; // Student ID as the second argument

            classEnrollments.add(new Class_Enrollment__c(Class__c = classId, Student__c = stundetId));
        }

        insert classEnrollments;
    }

    public static void setGrade(Id classId, Id studentId, Integer grade) {

        // Set grade based on given class and student.
        update new class_Enrollment__c(Id = [SELECT Id FROM Class_Enrollment__C WHERE Class__r.Id = :classId AND Student__r.Id = :studentId LIMIT 1].Id, Grade__c = grade);
    }
    
    public static void setGrade(Id classEnrollmentId, Integer grade) {

        // Set grade for given class enrollment.
        update new class_Enrollment__c(Id = classEnrollmentId, Grade__c = grade);
    }

    public static void setAcademicScholarship(Id studentId) {

        // Assign academic scholarship to a given student.
        update new Student__c(Id = studentId, Scholarship__c = 'Academic');
    }

    // Calculate if the student has a scholarship by the results of the year.
    public static void recalculateScholarship(Id studentId) {

        Decimal studentAverageGrades = [SELECT Average_Grade__c FROM Student__c WHERE Id = :studentId].Average_Grade__c;
        
        // If at least one class enrollment has no 
        // grade - a scholarship cannot be assigned yet.
        if (studentAverageGrades == null || studentAverageGrades < 71){
            update new Student__c(Id = studentId, Scholarship__c = 'Unassigned');
        }
        // In order to have a scholarship, students must have 
        // an average grade between 71 and 87 of all attended classes.
        else if (studentAverageGrades < 87 && studentAverageGrades >= 71){
            update new Student__c(Id = studentId, Scholarship__c = 'Regular');
        }
        // In order to have increased scholarship, students must 
        // have an average grade higher than 88 of all attended classes.
        else if (studentAverageGrades >= 88){
            update new Student__c(Id = studentId, Scholarship__c = 'Increased');
        }    
    }
}
