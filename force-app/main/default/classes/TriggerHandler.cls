public virtual class TriggerHandler {
    protected List<sObject> newList;
    protected List<sObject> oldList;
    protected Map<Id, sObject> newMap;
    protected Map<Id, sObject> oldMap;

    protected Integer size;

    public TriggerHandler() {
        this.newList = Trigger.new;
        this.oldList = Trigger.old != null ? Trigger.old : null;

        this.newMap = Trigger.newMap;
        this.oldMap = Trigger.oldMap != null ? Trigger.oldMap : null;

        this.size = Trigger.size;
    }
    public void run() {
        switch on Trigger.operationType {
            when BEFORE_INSERT {
                this.beforeInsert();
            }
            when AFTER_INSERT {
                this.afterInsert();
            }
            when BEFORE_UPDATE {
                this.beforeUpdate();
            }
            when AFTER_UPDATE {
                this.afterUpdate();
            }
        }
    }
    protected virtual void beforeInsert() {
    }
    protected virtual void afterInsert() {
    }
    protected virtual void beforeUpdate() {
    }
    protected virtual void afterUpdate() {
    }
}