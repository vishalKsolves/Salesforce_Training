public class DeleteStudentBelowCriteria implements Database.Batchable<sObject>, Database.Stateful {
    public Integer countDeleteMarked = 0;
    public Database.QueryLocator start(Database.BatchableContext bc)
    {
        Date prevDate = Date.today().addDays(-2);
        return Database.getQueryLocator('SELECT Id,Is_Registration_Completed__c FROM Student__c WHERE (CreatedDate <= :prevDate AND Is_Registration_Completed__c = false)');
    }
    public void execute(Database.BatchableContext bc, List<Student__c> scope){
        for(Student__c student : scope)
        {
            student.Mark_For_Delete__c = 'YES';
            countDeleteMarked = countDeleteMarked + 1;
        }
        update scope;
    }
    public void finish(Database.BatchableContext bc)
    {
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id = :bc.getJobId()];
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[]{job.CreatedBy.Email};
        mail.setToAddresses(toAddresses);
        mail.setSubject(job.Status);
        mail.setPlainTextBody('No of students marked for deletion : ' + job.TotalJobItems + 'with '+ job.NumberOfErrors + ' failures.');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
    }
}
