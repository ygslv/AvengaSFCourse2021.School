public class LectureHandlerTrigger {
    
    public static void handleInsertion(List<Lecture__c> lectures) {
     
        exceptionByTimeOfTheEvent(lectures);
        addEndDate(lectures);

    }

    public static void exceptionByTimeOfTheEvent(List<Lecture__c> lectures) {

        for (Lecture__c lecture : lectures) {

            if ( lecture.Start_Date__c > lecture.End_Date__c) {

                lecture.addError('The beginning of the lecture cannot be later than the end of the lecture');
            }
        }
    }

    public static void addEndDate(List<Lecture__c> lectures) {

        for (Lecture__c lecture : lectures) {

            if (lecture.End_Date__c == NULL) {

                lecture.End_Date__c = lecture.Start_Date__c.addMinutes(90);
            }
        }
    }

}
