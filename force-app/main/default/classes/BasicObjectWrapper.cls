public virtual class BasicObjectWrapper {
    @AuraEnabled public String id;
    
    public BasicObjectWrapper(sObject item) {
        this.id = item.Id;
    }
    public BasicObjectWrapper() {
    }
}