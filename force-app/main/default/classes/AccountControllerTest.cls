@isTest
public with sharing class AccountControllerTest {
    @isTest
    static void AccountControllerTest() {
        List<Account> accList = new List<Account>();
        for(integer i=0;i<=10;i++){
            Account a = new Account(Name='a'+i);
            accList.add(a);
        }
        insert accList;
        Test.startTest();
        AccountController.findAccounts('a');
        Test.stopTest();
    }
}
