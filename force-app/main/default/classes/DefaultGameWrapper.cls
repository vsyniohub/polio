public virtual class DefaultGameWrapper extends DefaultWrapper{
    private final static String REJECTED_STRING = 'No data found';

    public Game_Session__c session;

    @AuraEnabled public String sessionCode;

    @AuraEnabled public GameSessionUnitWrapper currentStep;

    public DefaultGameWrapper() {
        this.result = new DefaultWrapper.Result(null, null);
    }
    public DefaultGameWrapper(Game_Session__c session) {
        rejectWhenNull(session);

        this.id                 = session.Id;
        this.sessionCode        = session.Session_Code__c;

        this.result = new Result(null, null);
    }

    public DefaultGameWrapper setCurrentStep() {
        if (session == null)
            return this;
        if (session.Current_Step__c != null) 
            this.currentStep = new GameSessionUnitWrapper(session.Current_Step__r);

        return this;
    }

    private void rejectWhenNull(Game_Session__c session) {
        AuraHandledException auraRejected = new AuraHandledException(REJECTED_STRING);
        auraRejected.setMessage(REJECTED_STRING);
        
        if (session == null) throw auraRejected;
    } 
}