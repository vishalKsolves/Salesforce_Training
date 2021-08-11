trigger StudentHistory on Student__c (after update) {
    List<Student_History__c> stuHistoryList = new List<Student_History__c>();
    String type = 'Student__c';
    Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
    Schema.SObjectType leadSchema = schemaMap.get(type);
    Map<String, Schema.SObjectField> mapFields = leadSchema.getDescribe().fields.getMap();
 


    for(Student__c student : Trigger.new)
    {
        Student__c oldStudent = Trigger.oldMap.get(student.Id);
        for (String str : mapFields.keyset()) 
        {
            Student_History__c stuHistory = new Student_History__c();
            if(str=='lastmodifieddate' || str=='systemmodstamp')
                continue;
                
            if(student.get(str) != oldStudent.get(str))
            {
                stuHistory.Field_Name__C = mapFields.get(str).getDescribe().getLabel();
                if (mapFields.get(str).getDescribe().getLabel() == 'Mentor') {
                    stuHistory.Old_Value__c = [
                        SELECT Name
                        FROM Mentor__c
                        WHERE Mentor__c.id = :String.valueOf(oldStudent.get(str))
                      ].Name;
                    stuHistory.New_Value__c = [
                        SELECT Name
                        FROM Mentor__c
                        WHERE Mentor__c.id = :String.valueOf(student.get(str))
                      ].Name;
                }
                else{
                    stuHistory.Old_Value__c = String.valueOf(oldStudent.get(str));
                    stuHistory.New_Value__c = String.valueOf(student.get(str));
                }
                stuHistory.Record_Id__c = String.valueOf(student.Id);
                stuHistoryList.add(stuHistory);
            }
        }
    }

    insert stuHistoryList;
}