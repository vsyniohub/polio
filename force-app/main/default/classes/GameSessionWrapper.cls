global without sharing class GameSessionWrapper extends DefaultGameWrapper {
    @AuraEnabled public List<GameSessionUnitWrapper> units;
    @AuraEnabled public GameSessionUnitWrapper currentUnit;

    public String currentUnitId;

    public GameSessionWrapper(Game_Session__c session) {
        super(session);
        
        this.currentUnitId = session.Current_Step__c;
        //this.setUnits(session.Game_Units__r);
    }

    public void setUnits(List<Game_Unit__c> units) {
        if (this.units == null) this.units = new List<GameSessionUnitWrapper>();
        for (Game_Unit__c gu : units) {
            this.units.add(new GameSessionUnitWrapper(gu));
        }
    }
    public void setCurrentUnit(Game_Unit__c unit) {
        if (unit != null) this.currentUnit = new GameSessionUnitWrapper(unit);
    }
}