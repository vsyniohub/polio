public with sharing class GameSessionController {
    @AuraEnabled
    public static GameRequestWrapper requestSession(String sessionCode) {
        return new GameRequestWrapper(
            GameSessionSelector.getInstance().getRecordByConjunction(getRequestConditions(sessionCode))
        );
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

    @AuraEnabled
    public static PartnerRegistrationWrapper registerParticipant(String sessionId, String nickName) {
        PartnerRegistrationWrapper wrapper;

        try {
            wrapper = new PartnerRegistrationWrapper(
                ParticipantRegistrationService.getInstance().invoke(
                    sessionId, 
                    nickName
                )
            );
            wrapper.setResult(
                DefaultWrapper.OK, 
                'Success'
            );
        } catch (Exception e) {
            wrapper = new PartnerRegistrationWrapper();
            wrapper.setResult(
                DefaultWrapper.ERROR, 
                e.getMessage()
            );
        }
        return wrapper;
    }

    private static Map<String, String> getRequestConditions(String sessionCode) {
        return new Map<String, String>{'Session_Code__c' => sessionCode};
    }
    private static Map<String, String> getUnitsConditions(String sessionId) {
        return new Map<String, String>{'Game_Session__c' => (Id)sessionId};
    }
}