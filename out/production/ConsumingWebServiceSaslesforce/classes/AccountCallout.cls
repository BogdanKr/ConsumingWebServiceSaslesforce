/**
 * Created by Bogdan on 16.09.2020.
 */

public with sharing class AccountCallout {
    public static Account getAccountById(String accountId) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setHeader('Authorization', 'Bearer ' + AccessToTrailheadOrg.getRequestToken());
        request.setEndpoint('https://cunning-fox-2asnae-dev-ed.my.salesforce.com/services/apexrest/Accounts/' + accountId);
//        request.setEndpoint('https://cunning-fox-2asnae-dev-ed.my.salesforce.com/services/data/v49.0/sobjects/account/' + accountId);
        request.setMethod('GET');


        HttpResponse response = http.send(request);
        System.debug('StatusCode: ' + response.getStatusCode());
        Account thisAccount = (Account) JSON.deserialize(response.getBody(), Account.class);
        System.debug(thisAccount);
        if (thisAccount.Contacts.size() != 0) {
            for (Contact contact : thisAccount.Contacts) {
                System.debug(contact);
            }
            System.debug('Contacts size: ' + thisAccount.Contacts.size());
        }
        return thisAccount;
    }

    public static HttpResponse createNewAccount(String name, String description) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setHeader('Authorization', 'Bearer ' + AccessToTrailheadOrg.getRequestToken());
        request.setEndpoint('https://cunning-fox-2asnae-dev-ed.my.salesforce.com/services/apexrest/Accounts/');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"name":"' + name + '", "description":"' + description + '"}');
        HttpResponse response = http.send(request);
        System.debug(response.getStatusCode());

        // Parse the JSON response
        if (response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' +
                    response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }
        return response;
    }

    public static HttpResponse deleteAccountById(String accountId) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setHeader('Authorization', 'Bearer ' + AccessToTrailheadOrg.getRequestToken());
        request.setEndpoint('https://cunning-fox-2asnae-dev-ed.my.salesforce.com/services/apexrest/Accounts/' + accountId);
        request.setMethod('DELETE');

        HttpResponse response = http.send(request);
        System.debug('StatusCode: ' + response.getStatusCode());
        return response;
    }

    public static HttpResponse upsertAccount(String id, String name, String phone, String website) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setHeader('Authorization', 'Bearer ' + AccessToTrailheadOrg.getRequestToken());
        request.setEndpoint('https://cunning-fox-2asnae-dev-ed.my.salesforce.com/services/apexrest/Accounts/');
        request.setMethod('PUT');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"id":"' + id + '","name":"' + name +
                '","phone":"' + phone + '", "website":"' + website + '"}');
        HttpResponse response = http.send(request);
        System.debug(response.getStatusCode());

        // Parse the JSON response
        if (response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' +
                    response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }
        return response;
    }

    public static HttpResponse updateAccount(String id, String name, String phone, String website) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setHeader('Authorization', 'Bearer ' + AccessToTrailheadOrg.getRequestToken());
        request.setEndpoint('https://cunning-fox-2asnae-dev-ed.my.salesforce.com/services/apexrest/Accounts/'+ id);
        request.setMethod('PATCH');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"name":"' + name +
                '","phone":"' + phone + '", "website":"' + website + '"}');
        HttpResponse response = http.send(request);
        System.debug(response.getStatusCode());

        // Parse the JSON response
        if (response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' +
                    response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }
        return response;
    }
}