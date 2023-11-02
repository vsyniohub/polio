import { api, LightningElement } from 'lwc';
import getSession from "@salesforce/apex/GameSessionController.getSession";

export default class MainPage extends LightningElement { 
    enteredCode;

    async checkCode() {
        try {
            const retrieveResult = await getSession({
                sessionCode : this.enteredCode
            });
            this.redirectWhenFound(retrieveResult);
        } catch (error) {
            
        }
        
    }
    codeChanged(event) {
        this.enteredCode = event.detail.value;
    }
    redirectWhenFound(o) {
        if (o.sessionCode !== undefined) window.open("/apex/game?gameCode="+o.sessionCode,'_top');
    }
}