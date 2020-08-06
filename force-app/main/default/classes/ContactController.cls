//new class for contacts
public with sharing class ContactController {
    public List<Contact> getContacts() {
        return [select id,name from contact limit 10];
    }
}
