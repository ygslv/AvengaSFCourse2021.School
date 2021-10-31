public class HttpCalloutClassEnrollment {

  public static HttpResponse HttpCalloutClassEnrollment(Id classEnrollmentId) {

    Http http = new Http();
    HttpRequest req = new HttpRequest();

    req.setHeader('recordId', classEnrollmentId);
    req.setEndpoint('https://avenga-school.herokuapp.com/delete-record');
    req.setMethod('DELETE');

    HttpResponse res = http.send(req);

    return res;
  }

  @AuraEnabled
  public static void HttpCalloutDeletingClassEnrollment(Id classEnrollmentId) {

    Integer statusCode = HttpCalloutClassEnrollment(classEnrollmentId).getStatusCode();

    Class_Enrollment__c ce = new Class_Enrollment__c(Id = classEnrollmentId);

    if (statusCode == 200) {

      try {
          
        delete ce;
      } catch (Exception e) {
          
        ce.addError('There is no such Class Enrollment\n' + e.getMessage());
      }
    } else {

      ce.addError('Http callout return ' + statusCode + ' status code');
    }    
  }
}