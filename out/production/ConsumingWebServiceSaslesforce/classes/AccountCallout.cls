/**
 * Created by Bogdan on 16.09.2020.
 */

public with sharing class AccountCallout {

    public static Account getAccountById(String accountId) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setHeader('Authorization', 'Bearer ' + AccessToTrailheadOrg.getRequestToken());
        request.setHeader('Content-Type', 'application/json');
        request.setEndpoint('https://cunning-fox-2asnae-dev-ed.my.salesforce.com/services/apexrest/Accounts/' + accountId + '/contacts');
        request.setMethod('GET');

        HttpResponse response = http.send(request);
        Account thisAccount = new Account();
        System.debug('StatusCode: ' + response.getStatusCode());
        thisAccount = (Account) JSON.deserialize(response.getBody(), Account.class);
        System.debug(thisAccount);
        if (thisAccount.Contacts.size() != 0) {
            for (Contact contact : thisAccount.Contacts) {
                System.debug(contact);
            }
            System.debug('Contacts size: ' + thisAccount.Contacts.size());
        }
        return thisAccount;
    }

    public static HttpResponse makePostCallout() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"name":"mighty moose2"}');
        HttpResponse response = http.send(request);
        // Parse the JSON response
        if (response.getStatusCode() != 201) {
            System.debug('The status code returned was not expected: ' +
                    response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }
        return response;
    }
}