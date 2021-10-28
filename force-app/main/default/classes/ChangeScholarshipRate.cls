public class ChangeScholarshipRate implements Schedulable {
    
    public void execute(SchedulableContext ctx) {

        Database.executeBatch(new ScholarshipRateBatch());
    }
}