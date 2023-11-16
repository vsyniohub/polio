import { api, LightningElement } from 'lwc';
import getSession from "@salesforce/apex/GameSessionController.requestSession";

export default class MainPage extends LightningElement { 
    enteredCode = '1232412';
    enteredName = 'Some';

    FINALS = {
        SUCCESS : 'SUCCESS',
        ERROR   : 'ERROR'
    }

    async checkCode() {
        try {
            const retrieveResult = await getSession({
                sessionCode : this.enteredCode
            });
            if (retrieveResult.result.status === this.FINALS.ERROR) {
                this.setValidity('codeInput', retrieveResult.result.message);
            } else {
                this.redirectWhenFound(retrieveResult);
            }
        } catch (error) {
            console.log(error);
        }
        
    }
    codeChanged(event) {
        this.setValidity('codeInput','');
        this.enteredCode = event.detail.value;
    }
    redirectWhenFound(o) {
        if (o.sessionCode !== undefined) window.open("/apex/game?gameCode="+o.sessionCode,'_top');
    }
    nickNameChanged(event) {
        this.setValidity('nameInput','');

        this.enteredName = event.detail.value;
        if (this.enteredName === undefined || this.enteredName === '') {
            this.setValidity('nameInput', 'Enter the name');
        }
    }
    validateInputs(result){

    }
    setValidity(inputName, message) {
        var input = this.template.querySelector('lightning-input[data-name="'+inputName+'"]');
        input.setCustomValidity(message);
        input.reportValidity();
    }
}