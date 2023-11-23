import { track, api, LightningElement } from 'lwc';
import getSession from "@salesforce/apex/GameSessionController.getSession";
import submitReply from "@salesforce/apex/GameSessionController.submitReply";

export default class GameInstance extends LightningElement {
    @api code;
    @api participant;

    @track counter = {
        duration : 10,
        initialDuration : 10,
        timeString : '',
        secondDuration : 1000
    }

    timerInterval;
    time;

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

            this.setCounter(this.currentUnit);
            this.startTimer();
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
    returnSelectedAttribute(attribute) {
        return this.currentUnit.items
            .filter(item => {return item.selected === true})
            .map(item => item[attribute]);
    }
    lessThanTen(t) {
        return t < 10 ? '0' + t : t;
    }
    startTimer() {
        var globalThis = this;

        this.timerInterval = setInterval(function() {   
            globalThis.counter.duration -= 1;

            globalThis.counter.timeString = 
                globalThis.lessThanTen(Math.floor(globalThis.counter.duration / 60)) + 
                ' : ' + 
                globalThis.lessThanTen(globalThis.counter.duration % 60);
            
                if (globalThis.counter.duration === 0) {
                    globalThis.stopTimer();
                    globalThis.submitAnswer();
                }
        }, this.counter.secondDuration);
    }
    stopTimer() {
        clearInterval(this.timerInterval);
    }
    setCounter(unit) {
        this.counter.duration = this.counter.initialDuration = unit.duration;
        this.counter.timeString = this.lessThanTen(Math.floor(this.counter.duration / 60)) + ' : ' + this.lessThanTen(this.counter.duration % 60);
    }
    get selectedItemsReplies() {
        return this.returnSelectedAttribute('answer');
    }
    get selectedItemsIds() {
        return this.returnSelectedAttribute('id');
    }
    get calculatedTime() {
        return this.counter.timeString;
    }
    get completetionText() {
        return "Your answer has been submitted: <b>" + this.selectedItemsReplies + "</b>";
    }
}