trigger lectureTrigger on Lecture__c (before insert) {

    if (Trigger.isBefore) {

        if (Trigger.isInsert) {

            LectureHandlerTrigger.handleBeforeInsertion(Trigger.new);
        }
    }
    
}