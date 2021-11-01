@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {

    global HttpResponse respond(HTTPRequest req) {
        
        HttpResponse res = new HttpResponse();
        res.setStatusCode(200);
        return res;
    }
}