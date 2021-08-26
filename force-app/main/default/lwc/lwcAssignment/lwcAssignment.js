import { LightningElement, api, wire } from 'lwc';
import getObjectName from '@salesforce/apex/QueryBuilder.getObjectName';
import getFields from '@salesforce/apex/QueryBuilder.getFields';
import getQueryResults from '@salesforce/apex/QueryBuilder.getQueryResults';
export default class LwcAssignment extends LightningElement {
    value = 'inProgress';
    options = [];
    objects = [];
    fields = [];
    _selected = [];
    records = [];
    queryText = '';
    tableVisibility = false;
    connectedCallback() {
        getObjectName()
            .then(result => {
                this.objects = result;
                for (let o in this.objects) {
                    this.options = [...this.options, { label: this.objects[o], value: this.objects[o] }];
                }
            })
            .catch(error => {
                console.log(error);
            });
    }

    get options() {
        return this.options;
    }

    handleChange(event) {
        this.tableVisibility = false;
        this.fields = [];
        this._selected = [];
        this.records = [];
        this.queryText = '';
        this.value = event.detail.value;
        getFields({sObjectAPIName : this.value})
            .then(result => {
                for (let fields in result) {
                    this.fields = [...this.fields, { label: result[fields], value: result[fields] }];

                }
            })
            .catch(error => {
                console.log(error);
            });
    }


    get dualOptions() {
        return this.fields;
    }

    get selected() {
        return this._selected.length ? this._selected : 'none';
    }

    handleDualList(e) {
        this.tableVisibility = false;
        this.records = [];
        this.queryText = [];
        this._selected = e.detail.value;
        this.queryText = "SELECT ";
        let selectedValues = this._selected;
        
        for (let i = 0; i < selectedValues.length; i++) {
            if (i == selectedValues.length - 1) {
                this.queryText += selectedValues[i];
                break;
            }
            this.queryText += selectedValues[i] + ", ";
        }
        this.queryText += " FROM " + this.value;
    }

    get generatedQuery() {
        return this.queryText;
    }

    handleButtonClick() {
        getQueryResults({query : this.queryText, selectedValues : this._selected})
            .then(result => {
                this.records = result;
                this.tableVisibility = true;
            })
            .catch(error => {
                console.log(error);
            });
    }

    get records() {
        return this.records;
    }

    get isDisabled() {
        if(this.queryText === '')
            return true;
        return false;
    }

    get shouldVisible() {
        return this.tableVisibility;
    }
}