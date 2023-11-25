trigger GameSessionTrigger on Game_Session__c (before insert, after insert, before update, after update) {
    new GameSessionTriggerHandler().run();
}