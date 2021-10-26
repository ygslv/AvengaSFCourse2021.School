public class ClassesForStudentLWCComponent {
    
    @AuraEnabled(cacheable=true)
    public static List<ClassesForCurrentStudentWrapper> getClassesForCurrentStudent(Id studentId) {

        List<Class_Enrollment__c> classEnrollments = [
            SELECT Class__r.Year_of_Study__c, Class__r.Subject__c, Class__r.Name
            FROM Class_Enrollment__c 
            WHERE Student__r.Id = : studentId 
            AND Class__r.Year__c = :string.valueof(System.today().year())
            WITH SECURITY_ENFORCED
       ];   

       List<ClassesForCurrentStudentWrapper> wrapperList = new List<ClassesForCurrentStudentWrapper>();

       for (Class_Enrollment__c classEnrollment : classEnrollments) {

        ClassesForCurrentStudentWrapper wrapper = new ClassesForCurrentStudentWrapper(classEnrollment.Class__r.Year_of_Study__c,
            classEnrollment.Class__r.Subject__c, classEnrollment.Class__r.Name);

        wrapperList.add(wrapper);
       }
       
       return wrapperList;
    }

    public class ClassesForCurrentStudentWrapper {
        
        @AuraEnabled
        public String yearOfStudy;
        
        @AuraEnabled
        public String subject;

        @AuraEnabled
        public String className;
        
        public ClassesForCurrentStudentWrapper(String yearOfStudy, String subject, String className) {

            this.yearOfStudy = yearOfStudy;
            this.subject = subject;
            this.className = className;
        }
    }
}