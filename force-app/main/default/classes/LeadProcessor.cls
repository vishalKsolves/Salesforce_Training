public class LeadProcessor implements Database.Batchable<sObject>{
        public Database.QueryLocator start(Database.BatchableContext bc) {
            return Database.getQueryLocator('SELECT Id, LeadSource FROM Lead');
        }

        public void execute(Database.BatchableContext bc, List<Lead> scope){
            List<Lead> leads = new List<Lead>();
            for(Lead lead : scope)
            {
                lead.LeadSource = 'Dreamforce';
                leads.add(lead);
            }
            update leads;
        }

        public void finish(Database.BatchableContext bc){
            System.debug('Processed a Batch');
        }
}