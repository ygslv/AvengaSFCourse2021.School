public class ChangeLectureStatusBatch implements Database.Batchable<SObject> {

    //Map <Datetime, List<Lecture__c>> lecturesMap = new Map<Datetime, List<Lecture__c>>();

    public Database.QueryLocator start(Database.BatchableContext bc) {

        String lectureQuery = 'SELECT Id, Start_Date__c, End_Date__c FROM Lecture__c ORDER BY Start_Date__c';
        
        return Database.getQueryLocator( lectureQuery );
    }

    public void execute(Database.BatchableContext bc, List<Lecture__c> scope) {

        // List<Lecture__c> lecturesList = new List<Lecture__c>();

        // for (Lecture__c c : scope) {

        //     if (lecturesMap.isEmpty()) {

        //         lecturesList.add(c);
        //         lecturesMap.put(c.Start_Date__c, lecturesList);
        //     }
        //     else if ( lecturesMap.containsKey(c.Start_Date__c) ) {

        //         lecturesList.add(c);
        //         lecturesMap.put(c.Start_Date__c, lecturesList);
        //     }
        // }
    }

    public void finish(Database.BatchableContext bc) {}

    public static String startDateCronExpressionGenerator(List<Lecture__c> lectures) {

        String cronExpression;
        Datetime startDate;

        List<String> months = new List<String> {'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'};

        for (Lecture__c lecture : lectures) {

            startDate = lecture.Start_Date__c;

            cronExpression = (
                startDate.second() + ' ' + 
                startDate.minute() + ' ' +
                startDate.hour() + ' ' +
                startDate.day() + ' ' +
                months[startDate.month()-1] + ' ? ' +
                startDate.year());
        }

        return cronExpression;
    }

    public static String endDateCronExpressionGenerator(List<Lecture__c> lectures) {

        String cronExpression;
        Datetime endDate;

        List<String> months = new List<String> {'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'};

        for (Lecture__c lecture : lectures) {

            endDate = lecture.End_Date__c;

            cronExpression = (
                endDate.second() + ' ' + 
                endDate.minute() + ' ' +
                endDate.hour() + ' ' +
                endDate.day() + ' ' +
                months[endDate.month()-1] + ' ? ' +
                endDate.year());
        }

        return cronExpression;
    }
}   