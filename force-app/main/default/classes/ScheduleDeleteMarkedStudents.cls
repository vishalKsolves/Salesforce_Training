public class ScheduleDeleteMarkedStudents implements Schedulable{
    public void execute(SchedulableContext sc)
    {
        List<Student__c> studentsToBeDeleted = [SELECT Id FROM Student__c WHERE Mark_For_Delete__c = 'YES'];
        delete studentsToBeDeleted;
    }
}
