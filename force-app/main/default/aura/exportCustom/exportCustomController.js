({
    init: function (component, event, helper) {
        var action = component.get("c.getObjectNames");
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var allValues = response.getReturnValue();
                let fieldMap = [];
                for (let i = 0; i < allValues.length; i++) {
                    fieldMap.push({ label: allValues[i], value: allValues[i] });
                }
                component.set("v.dualOptions", fieldMap);
            }

        });
        $A.enqueueAction(action);
    },
    downloadCsv: function (component, event, helper) {
        let stockData = component.get("v.selectedFields");
        let csv = helper.convertArrayOfObjectsToCSV(component, stockData);
        if (csv == null) { return; }
        let hiddenElement = document.createElement('a');
        hiddenElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csv);
        hiddenElement.target = '_self';
        hiddenElement.download = 'Export.csv';
        document.body.appendChild(hiddenElement);
        hiddenElement.click();
    }
})
