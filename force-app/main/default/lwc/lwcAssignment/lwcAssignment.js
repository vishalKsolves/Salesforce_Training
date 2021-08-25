import { LightningElement, api, wire } from 'lwc';
import getObjectName from '@salesforce/apex/QueryBuilder.getObjectName';
import getFields from '@salesforce/apex/QueryBuilder.getFields';
export default class LwcAssignment extends LightningElement {
    value = 'inProgress';
    options = [];
    objects = [];
    fields = [];
    connectedCallback() {
        getObjectName()
            .then(result => {
                this.objects = result;
                for (let o in this.objects) {
                    this.options = [...this.options, { label: this.objects[o], value: this.objects[o] }];
                }
            })
            .catch(error => {
                // Handle error. Details in error.message.
            });
    }

    get options() {
        return this.options;
    }

    handleChange(event) {
        this.value = event.detail.value;
        getFields({sObjectAPIName : this.value})
            .then(result => {
                for (let fields in result) {
                    console.log(result.length);
                    this.fields = [...this.fields, { label: result[fields], value: result[fields] }];

                }
            })
            .catch(error => {
                console.log(error);
            });
    }

    _selected = [];

    get dualOptions() {
        return this.fields;
    }

    get selected() {
        return this._selected.length ? this._selected : 'none';
    }

    handleChange2(e) {
        this._selected = e.detail.value;
        let queryText = "SELECT ";
        let selectedValues = this._selected;
        for (let i = 0; i < selectedValues.length; i++) {
            if (i == selectedValues.length - 1) {
                queryText += selectedValues[i];
                break;
            }
            queryText += selectedValues[i] + ", ";
        }
        queryText += " FROM " + this.value;
    }
}