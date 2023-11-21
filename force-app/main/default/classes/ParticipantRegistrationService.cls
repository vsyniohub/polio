public with sharing class ParticipantRegistrationService {
    private final static Integer FIRST_ELEMENT = 0;

    private static ParticipantRegistrationService instance = null;
    private DMLHandler recordHandler = null;

    private ParticipantRegistrationService() {
        recordHandler = DMLHandler.getInstance();
    }
    public static ParticipantRegistrationService getInstance() {
        if (instance == null) instance = new ParticipantRegistrationService();

        return instance;
    }

    public Participant__c invokeSingular(String session, String nickname) {
        recordHandler.addNew(generateParticipant(session, nickname));

        recordHandler.commitWork();

        return getLastReply();
    }

    private Participant__c generateParticipant(String seesionId, String nickname) {
        return new Participant__c(
            Game_Session__c     = (Id)seesionId,
            Nickname__c         = nickname,
            Joined_DateTime__c  = DateTime.now()
        );
    }
    private Participant__c getLastReply() {
        return recordHandler.returnInsertedList().isEmpty() ? null : (Participant__c)recordHandler.returnInsertedList()[FIRST_ELEMENT];
    }
}