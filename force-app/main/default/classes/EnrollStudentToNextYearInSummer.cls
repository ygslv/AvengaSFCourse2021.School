public class EnrollStudentToNextYearInSummer implements Schedulable {
    
    public void execute(SchedulableContext ctx) {

        // String cronString = '0 0 0 15 JUN ? 2022/1'; // At 00:00:00am, on the 15th day, in June, starting in 2022

        // System.schedule(
        // 'Changing Year Of Study In Summer', 
        // cronString, 
        // new EnrollStudentToNextYearInSummer());

        Database.executeBatch(new EnrollStudentToNextYearBatch());
    }
}