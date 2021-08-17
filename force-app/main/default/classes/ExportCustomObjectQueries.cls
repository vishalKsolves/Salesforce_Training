public class ExportCustomObjectQueries {
    @AuraEnabled
    public static List<String> getObjectNames(){
        List<String> objects = new List<String>();
        List<Schema.SObjectType> sObjectList = Schema.getGlobalDescribe().Values();  
        for(SObjectType sObjectType : sObjectList){
            String name = sObjectType.getDescribe().getName();
            if(name.toLowerCase().right(3) ==  '__c')
                {
                    objects.add(name);
                }
        }
        objects.sort();
        return objects;
    }
}
