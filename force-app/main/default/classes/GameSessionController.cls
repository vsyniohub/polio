public with sharing class GameSessionController {
    public final static String ERROR_STRING = 'ERROR';

    @AuraEnabled
    public static GameRequestWrapper requestSession(String sessionCode) {
        try {
            return (GameRequestWrapper)new GameRequestWrapper(
                GameSessionSelector.getInstance().getRecordByConjunction(getRequestConditions(sessionCode))
            );
        } catch (Exception e) {
            return (GameRequestWrapper)new GameRequestWrapper().setResult(
                GameSessionController.ERROR_STRING, 
                e.getCause()
            );
        }
    }

    @AuraEnabled
    public static GameSessionWrapper getSession(String sessionCode) {
        GameSessionWrapper currentGame = new GameSessionWrapper(
            GameSessionSelector.getInstance().getRecordByConjunction(getRequestConditions(sessionCode))
        );

        currentGame.setCurrentUnit(
            GameUnitSelector.getInstance().getRecordById(currentGame.currentUnitId)
        );
        return currentGame;
    }

    private static Map<String, String> getRequestConditions(String sessionCode) {
        return new Map<String, String>{'Session_Code__c' => sessionCode};
    }
    private static Map<String, String> getUnitsConditions(String sessionId) {
        return new Map<String, String>{'Game_Session__c' => (Id)sessionId};
    }
}