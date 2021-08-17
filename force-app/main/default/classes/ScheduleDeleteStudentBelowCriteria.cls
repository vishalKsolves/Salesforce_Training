public class ScheduleDeleteStudentBelowCriteria implements Schedulable{
    public void execute(SchedulableContext sc)
    {
        DeleteStudentBelowCriteria dsbc = new DeleteStudentBelowCriteria();
        database.executeBatch(dsbc);
    }
}