@isTest
public class TestRestrictContactByName {
    @isTest static void TestContactRestriction() {
        List<Contact> myList = new List<Contact>();
        Contact con1 = new Contact(FirstName='Harry', LastName='INVALIDNAME');
        myList.add(con1);
        Contact con2 = new Contact(FirstName='Harry', LastName='Potter');
        myList.add(con2);

        Test.startTest();
        insert myList;
        Test.stopTest();
    }
}
