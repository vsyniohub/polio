import {  api, LightningElement } from 'lwc';
import getSession from "@salesforce/apex/GameSessionController.getSession";

export default class GameInstance extends LightningElement {
    @api code;

    units;
    response;
    async connectedCallback() {
        try {
            const retrieveResult = await getSession({
                sessionCode : this.code
            });
            this.response = retrieveResult;
            this.units = retrieveResult?.units;
        } catch (error) {
            console.log(error);
        }
    }
    handleSelection(event) {
    }
}