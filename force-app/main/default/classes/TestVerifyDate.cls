@isTest
public class TestVerifyDate {
    @isTest static void testWithin30Days() {
        Date date1 = Date.newInstance(2021, 1, 1);
        Date date2 = Date.newInstance(2021, 1, 19);
        System.assertEquals(VerifyDate.CheckDates(date1, date2),date2);
    }

    @isTest static void testNotWithin30Days() {
        Date date1 = Date.newInstance(2021, 1, 1);
        Date date2 = Date.newInstance(2021, 3, 19);
        System.assertEquals(VerifyDate.CheckDates(date1, date2),Date.newInstance(2021, 3, 31));
    }
}
