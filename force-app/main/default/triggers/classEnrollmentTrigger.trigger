trigger classEnrollmentTrigger on Class_Enrollment__c (before insert) {

    if (Trigger.isInsert){
        ClassEnrollmentHandlerTrigger.handleInsertion(Trigger.new);
    }
}