public with sharing class CampingListController {
    @AuraEnabled
    public static List<Camping_Item__C> getItems(){
        String[] fieldsToCheck = new String[]{'Id', 'Name', 'Price__c', 'Quantity__c', 'Packed__c'};
        Map<String, Schema.SObjectField> fieldDescribeTokens = Schema.SObjectType.Camping_Item__C.fields.getMap();
        for(String field : fieldsToCheck)
        {
            if(! fieldDescribeTokens.get(field).getDescribe().isAccessible())
            {
                throw new System.NoAccessException();
            }
        }
        return [SELECT Id, Name, Price__c, Quantity__c, Packed__c FROM Camping_Item__C];
    }
    @AuraEnabled
    public static Camping_Item__C saveItem(Camping_Item__C item){
        upsert item;
        return item;
    }
}
