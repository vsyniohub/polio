import { api, LightningElement } from 'lwc';
import getSession from "@salesforce/apex/GameSessionController.requestSession";

export default class MainPage extends LightningElement { 
    enteredCode = '1232412';

    async checkCode() {
        try {
            const retrieveResult = await getSession({
                sessionCode : this.enteredCode
            });
            this.redirectWhenFound(retrieveResult);
        } catch (error) {
            console.log(error);
        }
        
    }
    codeChanged(event) {
        this.enteredCode = event.detail.value;
    }
    redirectWhenFound(o) {
        if (o.sessionCode !== undefined) window.open("/apex/game?gameCode="+o.sessionCode,'_top');
    }
}