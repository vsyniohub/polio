import {  api, LightningElement } from 'lwc';
import getSession from "@salesforce/apex/GameSessionController.getSession";
import submitReply from "@salesforce/apex/GameSessionController.submitReply";

export default class GameInstance extends LightningElement {
    @api code;
    @api participant;

    FINALS = {
        SUCCESS : 'SUCCESS',
        ERROR   : 'ERROR'
    }
    
    inProgress = true;

    response = {};
    currentUnit = {};
    async connectedCallback() {
        try {
            const retrieveResult = await getSession({
                sessionCode : this.code
            });
            this.response = retrieveResult;
            this.currentUnit = this.response.currentUnit;
        } catch (error) {
            console.log(error);
        }
    }
    handleSelection(event) {
        const selectedId = event.detail;
        const selectedItem = this.currentUnit.items.find((item) => item.id === selectedId);

        selectedItem.selected = selectedItem.selected !== true ? true : false;
    }
    async submitAnswer(event) {
        try {
            const submitResult = await submitReply({
                currentStepId   : this.currentUnit.id, 
                participant     : this.participant, 
                replies         : this.selectedItemsIds
            });
            if (submitResult.result.status === this.FINALS.ERROR) {
            } else {
                this.inProgress = false;
            }
        } catch (error) {
            console.log(error);
        }
    }
    get selectedItemsReplies() {
        return this.returnSelectedAttribute('answer');
    }
    get selectedItemsIds() {
        return this.returnSelectedAttribute('id');
    }
    returnSelectedAttribute(attribute) {
        return this.currentUnit.items
            .filter(item => {return item.selected === true})
            .map(item => item[attribute]);
    }
}