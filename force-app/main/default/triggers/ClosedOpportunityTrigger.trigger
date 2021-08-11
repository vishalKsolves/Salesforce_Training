trigger ClosedOpportunityTrigger on Opportunity (before insert, after update) {
    List<Task> taskList = new List<Task>();
    for(Opportunity opp: trigger.new)
    {
        if(opp.StageName == 'Closed Won')
        {
            Task t = new Task();
            t.Subject = 'Follow Up Test Task';
            t.whatId = opp.Id;
            taskList.add(t);
        }
    }
    if(taskList.size() > 0)
    {
        insert taskList;
    }
}