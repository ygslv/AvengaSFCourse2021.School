@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {

    global HttpResponse respond(HTTPRequest req) {

        //System.assertEquals('https://avenga-school.herokuapp.com/delete-record', req.getEndpoint());
        //System.assertEquals('DELETE', req.getMethod());
        
        HttpResponse res = new HttpResponse();
        res.setStatusCode(200);
        return res;
    }
}