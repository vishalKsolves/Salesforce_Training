@isTest
public class AddPrimaryContactTest {
    @TestSetup
    static void makeData(){
        List<Account> accounts = new List<Account>();
        for(Integer i=1; i<=50; i++)
        {
            accounts.add(new Account(Name = 'Test Account ' + i, BillingState = 'NY'));
            accounts.add(new Account(Name = 'Test Account ' + (i+50), BillingState = 'CA'));
        }
        insert accounts;
    }
    @isTest
    static void test()
    {
        Contact myContact = new Contact(firstname = 'John', lastname = 'Wick');
        Test.startTest();
        System.enqueueJob(new AddPrimaryContact(myContact, 'CA'));
        Test.stopTest();

        System.assertEquals(50, [SELECT COUNT() FROM Account WHERE BillingState='CA']);
    }
}
