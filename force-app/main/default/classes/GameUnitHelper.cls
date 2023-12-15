public with sharing class GameUnitHelper {
    public static Game_Unit__c returnCompletedUnit(Id unitId) {
        return new Game_Unit__c(
            Id = unitId,
            Status__c = 'Closed' //move to a separate class contstant
        );
    }
    public static Unit_Completion__e generateCompletionEvent(Id gameSessionId, Id unitId) {
        return new Unit_Completion__e(
            Game_Unit_Id__c = unitId,
            Game_Session__c = gameSessionId,
            Type__c         = 'Completed'
        );
    }
}