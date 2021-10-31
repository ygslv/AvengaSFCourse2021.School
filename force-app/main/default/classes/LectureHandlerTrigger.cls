public class LectureHandlerTrigger {
    
    public static void handleInsertion(List<Lecture__c> lectures) {

        addEndDate(lectures);
    }

    public static void addEndDate(List<Lecture__c> lectures) {

        for (Lecture__c lecture : lectures) {

            if (lecture.End_Date__c == NULL) {

                lecture.End_Date__c = lecture.Start_Date__c.addMinutes(90);
            }
        }
    }

}
