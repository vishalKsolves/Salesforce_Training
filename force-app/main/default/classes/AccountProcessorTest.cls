@IsTest
public class AccountProcessorTest {
    
    @IsTest
    public static void countContactsTest() {
        Account account = new Account(Name = 'John Cena');
        insert account;

        List<Contact> relatedContacts = new List<Contact>();
        relatedContacts.add(New Contact(firstname = 'Roman', lastname = 'Reigns', AccountId = account.Id));
        relatedContacts.add(New Contact(firstname = 'Brock', lastname = 'Lesnar', AccountId = account.Id));
        relatedContacts.add(New Contact(firstname = 'Seth', lastname = 'Rollins', AccountId = account.Id));
        insert relatedContacts;

        List<Id> accountIds = new List<Id>();
        accountIds.add(account.Id);

        Test.startTest();
        AccountProcessor.countContacts(accountIds);
        Test.stopTest();

        Account ac = [SELECT Number_Of_Contacts__c FROM Account WHERE id = :account.Id];
        System.assertEquals(Integer.valueOf(ac.Number_Of_Contacts__c), 3);
    }
}
