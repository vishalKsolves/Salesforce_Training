public class MyController {
    public List<Mentor__c> mentors{get;set;}
    public List<Student__c> students{get;set;}
    public String instId{get;set;}
    public String mentorId{get;set;}
    public List<SelectOption> getStrings() 
    {
        List<SelectOption> options = new List<SelectOption>();
        List<Institute__c> instituteList = [SELECT Name FROM Institute__c];
        
        for (Integer i = 0; i < instituteList.size(); i++)
        {
            SelectOption option = new SelectOption(instituteList.get(i).id,instituteList.get(i).Name);
            options.add(option);
        }
       
        return options;
    }

    public void myMentors() 
    {
        mentors = [SELECT Id, Name, Designation__c FROM Mentor__c WHERE Institute__c = :instId];
    }

    public void students() 
    {
        students = [SELECT Name, Class__c, State__C, City__c FROM Student__c WHERE Mentor__c = :mentorId];
    }

}