trigger lectureTrigger on Lecture__c (before insert) {

    if (Trigger.isInsert){
        LectureHandlerTrigger.handleInsertion(Trigger.new);
    }
}