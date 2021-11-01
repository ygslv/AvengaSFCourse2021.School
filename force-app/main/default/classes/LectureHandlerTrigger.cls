public class LectureHandlerTrigger {
    
    public static void handleBeforeInsertion(List<Lecture__c> lectures) {
        
        // preventing creation lecture, when lecturer and lecture subject does not match
        exceptionBySubject(lectures);

        // Adding 1.5 hours to the start date to make end date if was blanc
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

        Set<Id> lecturerIds = new Set<Id>();

        for (Lecture__c lecture : lectures) {

            lecturerIds.add(lecture.Lecturer__c);
        }

        Map<Id, Lecturer__c> lecturers = new Map<Id, Lecturer__c>([SELECT Id, Subject__c FROM Lecturer__c WHERE Id IN :lecturerIds]);

        

        for (Lecture__c lecture : lectures) {

            if (!lecturers.get(lecture.Lecturer__c).Subject__c.contains(lecture.Lecture_Subject__c)) {

                lecture.addError('The subject for lecturer and lecture does not match');
            }
        }
    }
}