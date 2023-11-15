public virtual class DefaultGameWrapper extends BasicObjectWrapper{
    public Game_Session__c session;

    @AuraEnabled public String sessionCode;

    @AuraEnabled public GameSessionUnitWrapper currentStep;

    public DefaultGameWrapper() {
    }
    public DefaultGameWrapper(Game_Session__c session) {
        this.id                 = session.Id;
        this.sessionCode        = session.Session_Code__c;
    }

    public DefaultGameWrapper setCurrentStep() {
        if (session == null)
            return this;
        if (session.Current_Step__c != null) 
            this.currentStep = new GameSessionUnitWrapper(session.Current_Step__r);

        return this;
    }
}