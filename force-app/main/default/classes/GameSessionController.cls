public with sharing class GameSessionController {
    @AuraEnabled
    public static GameSessionWrapper getSession(String sessionCode) {
        Map<String, String> conditions = new Map<String, String>{'Session_Code__c' => sessionCode};
        return  new GameSessionWrapper(
            GameSessionSelector.getInstance().getRecordByConjunction(conditions)
        );        
    }
}