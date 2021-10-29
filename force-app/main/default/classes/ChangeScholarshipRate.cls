public class ChangeScholarshipRate implements Schedulable {
    
    public void execute(SchedulableContext ctx) {

        // String cronString = '0 0 0 1 * ?'; // At 00:00:00am, on the 1st day, every month

        // System.schedule(
        // 'Changing Scholarship Rate On Schedule', 
        // cronString, 
        // new ChangeScholarshipRate());

        Database.executeBatch(new ScholarshipRateBatch());
    }
}