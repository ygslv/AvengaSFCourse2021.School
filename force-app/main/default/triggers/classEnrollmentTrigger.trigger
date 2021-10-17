trigger classEnrollmentTrigger on Class_Enrollment__c (before insert) {

    ClassEnrollmentHandlerTrigger handler = new ClassEnrollmentHandlerTrigger();

    handler.handleInsertion(Trigger.new);
}