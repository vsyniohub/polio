public class GameSessionUnitWrapper extends BasicObjectWrapper{
    @AuraEnabled public String title;
    @AuraEnabled public String content;
    @AuraEnabled public String status;

    @AuraEnabled public Integer duration;

    @AuraEnabled public List<GameSessionUnitItemWrapper> items;

    public GameSessionUnitWrapper(Game_Unit__c unit) {
        super(unit);
        this.id         = unit.id;
        this.title      = unit?.Title__c;
        this.content    = unit?.Content__c;
        this.status     = unit?.Status__c;
        this.duration   = (Integer)unit?.Duration__c;

        this.setUnitItems(unit.Unit_Items__r);
    }
    public void setUnitItems(List<Unit_Item__c> unitItems) {
        if (this.items == null) this.items = new List<GameSessionUnitItemWrapper>();
        for (Unit_Item__c item : unitItems) {
            this.items.add(new GameSessionUnitItemWrapper(item));
        }
    }
}