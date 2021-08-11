({
    createItem : function(component,newCampingItem, event) {
        let myEvent = component.getEvent("addItem");
        var item = JSON.parse(JSON.stringify(newCampingItem));
        myEvent.setParams({
            "item" : item
        });
        myEvent.fire();
    } 
})
