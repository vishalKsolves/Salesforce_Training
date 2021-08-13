@isTest
public class DailyLeadProcessorTest {
    @TestSetup
    static void makeData(){
        List<Lead> leads = new List<Lead>();
        for(Integer i=1;i<=200;i++)
        {
            leads.add(new Lead(lastName = 'BlankLeadSource'+i, company = 'BlankLeadSource Company' , status = 'Open - Not Contacted'));
        }
        insert leads;
    }
    @isTest
    static void test(){
        Test.startTest();
        String jobId = System.schedule('DailyLeadProcessor', '0 0 12 * * ?', new DailyLeadProcessor());
        Test.stopTest();
        List<Lead> result = [SELECT Name, LeadSource FROM Lead WHERE LeadSource = 'Dreamforce' LIMIT 200];
        System.assertEquals(200, result.size());
    }
}
