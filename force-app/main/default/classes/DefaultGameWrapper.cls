public virtual class DefaultGameWrapper extends BasicObjectWrapper{
    private final static String REJECTED_STRING = 'No data found';

    public Game_Session__c session;

    @AuraEnabled public String sessionCode;

    @AuraEnabled public GameSessionUnitWrapper currentStep;
    @AuraEnabled public Result result;

    public DefaultGameWrapper() {
        this.result = new Result(null, null);
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

    public virtual Object setResult(String status, String message) {
        if (this.result == null) {
            this.result = new Result(status, message);
        } else {
            this.result.status = status;
            this.result.message = message;
        }
        
        return this;
    }

    private void rejectWhenNull(Game_Session__c session) {
        AuraHandledException auraRejected = new AuraHandledException(REJECTED_STRING);
        auraRejected.setMessage(REJECTED_STRING);
        
        if (session == null) throw auraRejected;
    }

    public class Result {
        @AuraEnabled public String status;
        @AuraEnabled public String message;

        public Result(String status, String message) {
            this.status = status;
            this.message = message;
        }

        @AuraEnabled 
        public String getStatusValue() {
            return this.status;
        }
        @AuraEnabled
        public String getMessageValue(){
            return this.message;
        }
    }
}