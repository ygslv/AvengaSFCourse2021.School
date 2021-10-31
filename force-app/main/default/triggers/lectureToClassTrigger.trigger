trigger lectureToClassTrigger on Lecture_to_Class__c (before insert) {

    if (Trigger.isInsert){
        LectureToClassHandlerTrigger.handleInsertion(Trigger.new);
    }
}