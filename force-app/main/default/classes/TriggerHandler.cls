public virtual class TriggerHandler {
    private final Integer MIN_DEPTH = 0;
    private final Integer MAX_DEPTH = 1;

    private String handlerName;

    protected List<sObject> newList;
    protected List<sObject> oldList;
    protected Map<Id, sObject> newMap;
    protected Map<Id, sObject> oldMap;

    protected Integer size;

    private static Map<String, Integer> depthCounter;

    public TriggerHandler(String triggerHandlerName) {
        if (depthCounter == null) depthCounter = new Map<String, Integer>{};

        this.handlerName = triggerHandlerName;

        this.newList = Trigger.new;
        this.oldList = Trigger.old != null ? Trigger.old : null;

        this.newMap = Trigger.newMap;
        this.oldMap = Trigger.oldMap != null ? Trigger.oldMap : null;

        this.size = Trigger.size;
    }
    public void run() {
        setDepthCounter();

        if (!validate()) return;

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

    protected virtual Boolean isChangedField(sObject checkObject, String fieldName) {
        return (
                (this.oldList == null) ||
                (checkObject.get(fieldName) != this.oldMap.get(checkObject.Id).get(fieldName))
            );
    }

    private void setDepthCounter() {
        if (depthCounter.containsKey(this.handlerName)) {
            depthCounter.put(
                this.handlerName, 
                depthCounter.get(this.handlerName) + 1
            );
        } else {
            depthCounter.put(this.handlerName, MIN_DEPTH);
        }
    }
    private Boolean validate() {
        return depthCounter.get(this.handlerName) <= MAX_DEPTH;
    }
}