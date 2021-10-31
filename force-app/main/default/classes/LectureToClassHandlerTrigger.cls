public class LectureToClassHandlerTrigger {
    
    public static void handleBeforeInsertion(List<Lecture_to_Class__c> lecturesToClasses) {

        exceptionByDuplicateLectures(lecturesToClasses);
        //exceptionByInOneTimeLectures(lecturesToClasses);
    }

    public static void exceptionByDuplicateLectures(List<Lecture_to_Class__c> lecturesToClasses){

        Set<Lecture_to_Class__c> myset = new Set<Lecture_to_Class__c>();
        List<Lecture_to_Class__c> lecturesToClassesNoDuplicates = new List<Lecture_to_Class__c>();

        Map<Id, Lecture_to_Class__c> existentlecturesToClasses = new Map<Id, Lecture_to_Class__c>(
            [SELECT 
                Lecture__c, Class__c
            FROM 
                Lecture_to_Class__c
            ]);
        
        // Remove duplicates from insertion list (Trigger.new)
        // Add Error about duplicates
        for (Lecture_to_Class__c currentLectureToClass : lecturesToClasses) {
            
            if (myset.add(currentLectureToClass)) {

                lecturesToClassesNoDuplicates.add(currentLectureToClass);
            }
            else {

                currentLectureToClass.addError('Such a lecture already exists in the current insertion');
            }
        }
        
        for (Lecture_to_Class__c currentLectureToClass : lecturesToClassesNoDuplicates) {

            Id currentClassId = currentLectureToClass.Class__c;
            Id currentLectureId = currentLectureToClass.Lecture__c;

            for (Id existentLectureToClassId : existentlecturesToClasses.keySet()) {
                
                Id existentClassId = existentlecturesToClasses.get(existentLectureToClassId).Class__c;
                Id existentLectureId = existentlecturesToClasses.get(existentLectureToClassId).Lecture__c;
                
                if (currentClassId == existentClassId && currentLectureId == existentLectureId){

                    currentLectureToClass.addError('Such a lecture already associated with the such class');
                }
            }
        }
    }

    // public static void exceptionByInOneTimeLectures(List<Lecture_to_Class__c> lecturesToClasses) {

    //     List <Id> lecturesId = new List<Id>();
    //     System.debug('L to C input: ' + lecturesToClasses[0]);
    //     System.debug('L id: ' + lecturesToClasses[0].Lecture__r.Id);

    //     for (Lecture_to_Class__c l : lecturesToClasses) {
            
    //         lecturesId.add(l.Lecture__r.Id);
    //     }

    //     System.debug('lectures id: ' + lecturesId);

    //     List<Lecture__c> lectures = [SELECT Id FROM Lecture__c WHERE Start_Date__c > :Datetime.now() AND Id NOT IN :lecturesId];

    //     System.debug('lectures: ' + lectures);

    //     // for (Lecture_to_Class__c lectureToClass : lecturesToClasses) {

    //     //     for (Lecture__c lecture : lectures) {

    //     //         if (lectureToClass.Lecture__r.Start_Date__c >= lecture.Start_Date__c && lectureToClass.Lecture__r.Start_Date__c < lecture.End_Date__c 
    //     //         && lectureToClass.Lecture__r.End_Date__c > lecture.Start_Date__c && lectureToClass.Lecture__r.End_Date__c < lecture.End_Date__c) {

    //     //             lectureToClass.addError('erora nahyi');
    //     //         }
    //     //     }
    //     // }
    // }
}
