/**
 * Created by Bogdan on 23.09.2020.
 */

public with sharing class AccountHttpCalloutMock implements HttpCalloutMock {

    public HttpResponse respond(HttpRequest request) {
        switch on request.getMethod() {
            when 'POST' {
                HttpResponse response = new HttpResponse();
                response.setHeader('Content-Type', 'application/json');
                response.setBody('{"name": "Test Name", "description": "Test Description"}');
                response.setStatusCode(200);
                return response;
            }
            when 'DELETE' {
                HttpResponse response = new HttpResponse();
                response.setStatusCode(200);
                return response;

            }
            when 'PUT' {
                HttpResponse response = new HttpResponse();
                response.setStatusCode(200);
                response.setBody(request.getBody());
                return response;
            }
            when 'PATCH' {
                HttpResponse response = new HttpResponse();
                response.setStatusCode(200);
                response.setBody(request.getBody());
                return response;
            }
        }

        return null;
    }
}