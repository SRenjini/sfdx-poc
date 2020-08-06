
@isTest
public with sharing class ContactControllerTest {
    @isTest
    public ContactControllerTest() {
        List<Contact> conList = new List<Contact>();
        for(integer i=0;i<=10;i++){
            Contact c = new Contact(LastName='c'+i,Email='c'+i+'@gmail.com');
            conList.add(c);
        }
        insert conList;
        Test.startTest();
            ContactController.getContacts();
        Test.stopTest();

    }
}
