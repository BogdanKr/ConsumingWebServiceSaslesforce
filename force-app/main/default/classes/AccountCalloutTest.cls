/**
 * Created by Bogdan on 23.09.2020.
 */

@IsTest
public with sharing class AccountCalloutTest {
    @IsTest
    public static void testGetAccountById() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAccountResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');

        Test.setMock(HttpCalloutMock.class, mock);

        Account thisAccount = AccountCallout.getAccountById('0000');

        System.assertNotEquals(null, thisAccount, 'The callout returned a null response.');
        System.assertEquals('Test record', thisAccount.Name);
        System.assertEquals('067 7777777', thisAccount.Phone);
    }

    @IsTest
    public static void testCreateNewAccount() {
        String accName = 'Test Name';
        String accDescription = 'Test Description';
        Test.setMock(HttpCalloutMock.class, new AccountHttpCalloutMock());
        HttpResponse response = AccountCallout.createNewAccount(accName, accDescription);

        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String expectedValue = '{"name": "' + accName + '", "description": "' + accDescription + '"}';
        String actualValue = response.getBody();
        System.assertEquals(expectedValue, actualValue);
        System.assertEquals(200, response.getStatusCode());
    }

    @IsTest
    public static void testDeleteAccountById() {
        String accId = '000000';
        Test.setMock(HttpCalloutMock.class, new AccountHttpCalloutMock());
        HttpResponse response = AccountCallout.deleteAccountById(accId);

        System.assertEquals(200, response.getStatusCode());
    }

    @IsTest
    static void testUpsertAccount() {
        String id = '01234';
        String name = 'Test';
        String phone = '00000';
        String website = 'site';
        Test.setMock(HttpCalloutMock.class, new AccountHttpCalloutMock());

        HttpResponse response = AccountCallout.upsertAccount(id, name, phone, website);

        String expectedValue = '{"id":"' + id + '","name":"' + name +
                '","phone":"' + phone + '", "website":"' + website + '"}';
        String actualValue = response.getBody();
        System.assertEquals(expectedValue, actualValue);
        System.assertEquals(200, response.getStatusCode());
    }

    @IsTest
    static void testUpdateAccount() {
        String id = '01234';
        String name = 'Test';
        String phone = '00000';
        String website = 'site';
        Test.setMock(HttpCalloutMock.class, new AccountHttpCalloutMock());

        HttpResponse response = AccountCallout.updateAccount(id, name, phone, website);

        String expectedValue = '{"name":"' + name +
                '","phone":"' + phone + '", "website":"' + website + '"}';
        String actualValue = response.getBody();
        System.assertEquals(expectedValue, actualValue);
        System.assertEquals(200, response.getStatusCode());
    }
}

