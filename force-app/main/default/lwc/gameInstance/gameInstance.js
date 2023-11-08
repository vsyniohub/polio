import {  api, LightningElement } from 'lwc';
import getSession from "@salesforce/apex/GameSessionController.getSession";

export default class GameInstance extends LightningElement {
    @api code;

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
    }
}