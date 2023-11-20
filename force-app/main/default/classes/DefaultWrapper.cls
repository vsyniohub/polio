public virtual class DefaultWrapper extends BasicObjectWrapper{
    
    public static final String OK      = 'OK';
    public static final String ERROR   = 'ERROR';

    @AuraEnabled public Result result;

    public DefaultWrapper() {

    }
    public DefaultWrapper(sObject singularObject) {

    }
    public DefaultWrapper(List<sObject> objectList) {

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