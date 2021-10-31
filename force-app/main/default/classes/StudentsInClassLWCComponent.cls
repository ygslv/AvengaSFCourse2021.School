public class StudentsInClassLWCComponent {
    
    @AuraEnabled(cacheable=true)
    public static List<StudentsForCurrentClassWrapper> getStudentsForCurrentClass(Id classId) {

        List<Class_Enrollment__c> classEnrollments = [
            SELECT Student__r.Name, Grade__c
            FROM Class_Enrollment__c 
            WHERE Class__r.Id = : classId
            ];   
            
        List<StudentsForCurrentClassWrapper> wrapperList = new List<StudentsForCurrentClassWrapper>();
            
        for (Class_Enrollment__c classEnrollment : classEnrollments) {

            wrapperList.add(new StudentsForCurrentClassWrapper(classEnrollment.Student__r.Name, string.valueOf(classEnrollment.Grade__c)));
        }

       return wrapperList;
    }

    public class StudentsForCurrentClassWrapper {
        
        @AuraEnabled
        public String studentName;
        
        @AuraEnabled
        public String grade;
        
        public StudentsForCurrentClassWrapper(String studentName, String grade) {

            this.studentName = studentName;
            this.grade = grade;
        }
    }
}