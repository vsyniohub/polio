import { api, LightningElement } from 'lwc';
import cometd from "@salesforce/resourceUrl/cometd";
import { loadScript } from "lightning/platformResourceLoader";
import getCometSession from "@salesforce/apex/GameSessionController.getSessionId";

export default class CompletedSection extends LightningElement {
    @api completionText;
    @api sessionId;

    FINALS = {
        COMPLETED : 'Completed',
        INITIATED : 'Initiated'
    }

    channelName = '/event/Unit_Completion__e';
    cometSessionId;

    async connectedCallback() {
        const cometSessionResult = await getCometSession();
        this.cometSessionId = cometSessionResult;

        if (cometSessionResult) 
            loadScript(this, cometd).then(() => {
                this.initializeCometD()
            });       
    }
    initializeCometD() {
        var componentContext = this;
        var cometdlib = new window.org.cometd.CometD();
        var usedUrl = window.location.protocol + '//' + window.location.hostname + '/cometd/51.0/';
        
        cometdlib.configure({
            url: usedUrl,
            requestHeaders: { Authorization: 'OAuth ' + this.cometSessionId},
            appendMessageTypeToURL : false,
            logLevel: 'debug'
        });
        cometdlib.websocketEnabled = false;
        cometdlib.handshake(function(status) {
            if (status.successful) {
                console.log('Subscribed');
                var subscription = cometdlib.subscribe(componentContext.channelName, function(message){
                    var eventContent = message?.data?.payload;
                    if (eventContent.Game_Session__c && eventContent.Game_Session__c === componentContext.sessionId) {
                        switch (eventContent.Type__c) {
                            case componentContext.FINALS.COMPLETED:
                                componentContext.callShowLeaders();
                            break;
                            case componentContext.FINALS.INITIATED:
                                componentContext.showNextUnit();
                            break;
                            default:
                                console.log('Default');
                        }
                    }
                   console.log(message);
                });
            } else {
                console.error(JSON.stringify(status));
            }
        });
    }
    callShowLeaders() {
        this.invokeEvent('showleaderstable', null);
    }
    showNextUnit() {
        this.invokeEvent('shownext', null);
    }
    invokeEvent(name, payload) {
        const event = new CustomEvent(name, { detail: {} });
        this.dispatchEvent(event);
    }
    get jsonResponse() {
        return JSON.stringify(this.subscription);
    }
}