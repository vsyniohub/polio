public with sharing class GameSessionUnitItemWrapper extends BasicObjectWrapper{
    @AuraEnabled public String answer;

    public GameSessionUnitItemWrapper(Unit_Item__c unitItem) {
        super(unitItem);
        this.answer = unitItem.Answer__c;
    }
}