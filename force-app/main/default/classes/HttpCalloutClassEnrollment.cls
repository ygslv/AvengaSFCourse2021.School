public class HttpCalloutClassEnrollment {

    public String HttpCalloutClassEnrollment(Id classEnrollmentId) {

        Http http = new Http();
        HttpRequest req = new HttpRequest();

        req.setHeader('Class Enrollment Id', string.valueof(classEnrollmentId));
        req.setEndpoint('https://avenga-school.herokuapp.com/delete-record');
        req.setMethod('DELETE');
    
        // Send the request, and return a response
        HttpResponse res = http.send(req);

        System.debug(res.getStatus());

        return res.getStatus();
      }
}
