public class AccountProcessor {
    @future
    public static void countContacts(List<Id> accountIDs) {
        List<Account> accounts = [SELECT Id, Number_Of_Contacts__c, (SELECT Id FROM Contacts) FROM Account where Id in :accountIDs];
        for(Account account : accounts)
        {
            account.Number_Of_Contacts__c = account.Contacts.size();
        }
        update accounts;
    }
}
