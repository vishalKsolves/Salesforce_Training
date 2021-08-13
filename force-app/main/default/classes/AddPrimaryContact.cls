public class AddPrimaryContact implements Queueable{
    private Contact contact;
    private String state;
    public AddPrimaryContact(Contact contact, String state) {
        this.contact = contact;
        this.state = state;
    }
    public void execute(QueueableContext context)
    {
        List<Contact> updatedList = new List<Contact>();
        for(Account acc : [SELECT Name FROM Account WHERE BillingState = :state LIMIT 200])
        {
            Contact clone = contact.clone(false, false, false, false);
            clone.AccountId = acc.Id;
            updatedList.add(clone);
        }
        insert updatedList;
    }
}
