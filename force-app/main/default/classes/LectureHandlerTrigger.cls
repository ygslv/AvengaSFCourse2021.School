public class LectureHandlerTrigger {
    
    public static void handleBeforeInsertion(List<Lecture__c> lectures) {
        
        exceptionBySubject(lectures);
        addEndDate(lectures);
    }

    public static void addEndDate(List<Lecture__c> lectures) {

        for (Lecture__c lecture : lectures) {

            if (lecture.End_Date__c == NULL) {

                lecture.End_Date__c = lecture.Start_Date__c.addMinutes(90);
            }
        }
    }

    public static void exceptionBySubject(List<Lecture__c> lectures) {

        List<Lecturer__c> lecturers = new List<Lecturer__c>();
        System.debug('current lecture' + lectures);

        //Set<Id> lecturersId = new Set<Id>();

        for (Lecture__c lecture : lectures) {
            lecturers.add(lecture.Lecturer__r);
            //lecturersId.add(lecture.Lecturer__r.Id);
        }
        System.debug('lecturer: ' + lecturers);
       // System.debug(lecturersId);

        // List<Lecturer__c> lecturersAfter = [SELECT Subject__c FROM Lecturer__c WHERE Id IN :lecturersId];

        // for (Lecture__c lecture : lectures) {

        //     System.debug(lecture.Lecture_Subject__c);  
        // }

        // System.debug(lecturersAfter);
    }

}