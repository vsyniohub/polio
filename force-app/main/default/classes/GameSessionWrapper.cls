global without sharing class GameSessionWrapper {
    public GameSessionWrapper(Game_Session__c session) {
        this.id = session.Id;
        this.sessionCode = session.Session_Code__c;
        if (session.Current_Step__c != null) this.currentStep = session.Current_Step__c;
    }
    @AuraEnabled public String id;
    @AuraEnabled public String currentStep;
    @AuraEnabled public String sessionCode;
}