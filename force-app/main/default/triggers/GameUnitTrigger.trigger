trigger GameUnitTrigger on Game_Unit__c (before insert, after insert, before update, after update) {
    new GameUnitTriggerHandler().run();
}