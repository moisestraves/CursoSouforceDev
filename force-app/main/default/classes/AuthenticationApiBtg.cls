public with sharing class AuthenticationApiBtg {
   
 BtgCredentialsApi__c  AuthCred =  BtgCredentialsApi__c.getInstance();

 String Clientid = AuthCred.ClienteId__c;
 String UrlApi = AuthCred.UrlApi__c;
 String ClientSecret = AuthCred.ClientSecret__c;

 String basic = EncodingUtil.base64Encode(Blob.valueof('Clientid :  ClientSecret'));

 




   
}