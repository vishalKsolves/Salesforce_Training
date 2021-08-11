({
    doInit : function(component, event, helper) {
        let action = component.get("c.getItems");
        action.setCallback(this, function(Response){
            let state = Response.getState();
            if(state === "SUCCESS")
            {
                component.set("v.items", Response.getReturnValue());
            }
            else{
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },
    handleAddItem : function(component, event){
        let items = event.getParam("item");
        
        let action = component.get("c.saveItem");
            action.setParams({
                "item": items
            });
        action.setCallback(this, function(response){
                let state = response.getState();
                if (state === "SUCCESS") {
                    let items = component.get("v.items");
                    items.push(response.getReturnValue());
                    component.set("v.items", items);
                }
            });
                $A.enqueueAction(action);
    component.set("v.newItem",{ 'sobjectType': 'Camping_Item__c','Name': '','Quantity__c': 0,
        'Price__c': 0,'Packed__c': false });
    }
})
