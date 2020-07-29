public with sharing class ContactController {
    public List<Contact> ContactController() {
        return [select id,name from contact limit 10];
    }
}
