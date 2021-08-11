public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer numberOfContacts, String lastName)
    {
        List<Contact> myContactList = new List<Contact>();
        for(Integer i=0;i<numberOfContacts;i++)
        {
            Contact c = new Contact(FirstName='Smith'+i, LastName=lastName);
            myContactList.add(c);
        }
        return myContactList;
    }
}
