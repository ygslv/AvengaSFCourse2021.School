public class LectureToClassHandlerTrigger {
    
    public static void handleInsertion(List<Lecture_to_Class__c> lecturesToClasses) {

        exceptionByInOneTimeLectures(lecturesToClasses);
    }

    public static void exceptionByInOneTimeLectures(List<Lecture_to_Class__c> lecturesToClasses) {

        List <Id> lecturesId = new List<Id>();
        System.debug('L to C input: ' + lecturesToClasses[0]);
        System.debug('L id: ' + lecturesToClasses[0].Lecture__r.Id);

        for (Lecture_to_Class__c l : lecturesToClasses) {
            
            lecturesId.add(l.Lecture__r.Id);
        }

        System.debug('lectures id: ' + lecturesId);

        List<Lecture__c> lectures = [SELECT Id FROM Lecture__c WHERE Start_Date__c > :Datetime.now() AND Id NOT IN :lecturesId];

        System.debug('lectures: ' + lectures);

        // for (Lecture_to_Class__c lectureToClass : lecturesToClasses) {

        //     for (Lecture__c lecture : lectures) {

        //         if (lectureToClass.Lecture__r.Start_Date__c >= lecture.Start_Date__c && lectureToClass.Lecture__r.Start_Date__c < lecture.End_Date__c 
        //         && lectureToClass.Lecture__r.End_Date__c > lecture.Start_Date__c && lectureToClass.Lecture__r.End_Date__c < lecture.End_Date__c) {

        //             lectureToClass.addError('erora nahyi');
        //         }
        //     }
        // }
    }
}
