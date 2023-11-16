public with sharing class ParticipantRegistrationService {
    private static ParticipantRegistrationService instance = null;
    private DMLHandler recordHandler = null;

    private ParticipantRegistrationService() {
        recordHandler = DMLHandler.getInstance();
    }
    public static ParticipantRegistrationService getInstance() {
        if (instance == null) instance = new ParticipantRegistrationService();

        return instance;
    }

    public Participant__c invoke(String session, String nickname) {
        recordHandler.addNew(generateParticipant(session, nickname));

        recordHandler.commitWork();

        return [SELECT Id FROM Participant__c LIMIT 1];
    }

    private Participant__c generateParticipant(String seesionId, String nickname) {
        return new Participant__c(
            Game_Session__c     = (Id)seesionId,
            Nickname__c         = nickname,
            Joined_DateTime__c  = DateTime.now()
        );
    }
}