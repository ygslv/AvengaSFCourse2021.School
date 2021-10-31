trigger lectureToClassTrigger on Lecture_to_Class__c (before insert) {

    if (Trigger.isBefore) {

        if (Trigger.isInsert) {
        
            LectureToClassHandlerTrigger.handleBeforeInsertion(Trigger.new);
        }
    }
}