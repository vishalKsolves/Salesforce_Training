@IsTest
public class LeadProcessorTest {
    @TestSetup
    static void setup() {
        List<Lead> leads = new List<Lead>();
        for(Integer i=1; i<200 ; i++)
        {
            leads.add(new Lead(lastname = 'Lead' + i , company = 'Lead Company' , status = 'Open - Not Contacted'));
        }
        insert leads;
    }

    @IsTest
    static void test() {
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Id batchId = Database.executeBatch(lp);
        Test.stopTest();
        System.assertEquals(200, [SELECT COUNT() FROM Lead WHERE LeadSource = 'Dreamforce']);
    }

}
