({
    convertArrayOfObjectsToCSV: function (component, objectRecords) {
        let csvStringResult, counter, keys, columnDivider, lineDivider;
        keys = ["Custom Objects"];

        if (objectRecords == null || !objectRecords.length) {
            return null;
        }

        columnDivider = ',';
        lineDivider = '\n';

        csvStringResult = '';
        csvStringResult += keys.join(columnDivider);
        csvStringResult += lineDivider;

        for (var i = 0; i < objectRecords.length; i++) {
            counter = 0;
            for(let j in keys)
            {
                if(counter>0)
                {
                    csvStringResult += columnDivider;
                }
                csvStringResult += '"' + objectRecords[i] + '"';
                counter++;
            }
            csvStringResult += lineDivider;
        }
        return csvStringResult;
    },
})