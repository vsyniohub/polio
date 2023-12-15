public with sharing class GameUnitTriggerHandler extends TriggerHandler {
    private DMLHandler recordHandler = null;

    public GameUnitTriggerHandler() {
        super(GameUnitTriggerHandler.class.getName());

        recordHandler = DMLHandler.getInstance();
    }

    public override void beforeInsert() {
    }
    public override void afterInsert() {
    }
    public override void beforeUpdate() {
        completeGameUnit();
    }
    public override void afterUpdate() {
        recordHandler.commitWork();
    }

    public void completeGameUnit() {
        for (Game_Unit__c gu : (List<Game_Unit__c>)this.newList) {
            if (this.isChangedField(gu, 'Status__c') && gu.Status__c == 'Closed') {
                recordHandler.addEvent(
                    GameUnitHelper.generateCompletionEvent(gu.Game_Session__c, gu.Id)
                );
            }
        } 
    }

    public override Boolean isChangedField(sObject checkObject, String fieldName) {
        Game_Unit__c gu = (Game_Unit__c)checkObject;
        return (
                (this.oldList == null) ||
                (checkObject.get(fieldName) != this.oldMap.get(checkObject.Id).get(fieldName))
            );
    }
}