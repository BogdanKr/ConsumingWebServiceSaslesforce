/**
 * Created by Bogdan on 16.09.2020.
 */

public with sharing class AccessToTrailheadOrg {
    private static String cKey = '3MVG9bhkrN.tsmW8eHlOPXee3X_jpwmFSbVFSveBO7XoKELxkHEang0ohF9QHMS4aWz2iJcs7yA==';
    private static String cSecret = 'A590E8D103290E928D8B103CFB345461D1FC4104C3307AA501CF361C87D6F2E3';
    private static String uName = 'krabog@cunning-fox-2asnae.com';
    private static String passwd = 'Kievstar19858Dd1I8iQn4w6LJQeD8Tds7qh';

    public class responseWrapper {
        public String id;
        public String access_token;
        public String instance_url;
    }
    public static String getRequestToken() {
        String reqBody = 'grant_type=password&client_id=' + cKey + '&client_secret=' + cSecret + '&username=' + uName + '&password=' + passwd;
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setBody(reqBody);
        req.setMethod('POST');
        req.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        HttpResponse hresp = h.send(req);
        responseWrapper wResp = (responseWrapper) JSON.deserialize(hresp.getBody(), responseWrapper.class);
        System.debug('Instance_url  ' + wResp.instance_url);

        return wResp.access_token;
    }
}