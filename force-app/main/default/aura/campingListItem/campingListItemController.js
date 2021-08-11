({
    packItem : function(component, event, helper) {
        component.set("v.item.Packed__c",true);
        event.getSource().set("v.disabled",true);
        // var a = component.get("v.item");
        // a.Packed__c = true;
        // component.set("v.item",a);
        // var btnClicked = event.getSource();
        // btnClicked.set("v.disabled",true);
    }
})
