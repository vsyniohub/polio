public with sharing class GameSessionSelector extends Selector {
    private final static String OBJECT_NAME = 'Game_Session__c';
    private final static Integer FIRST_ELEMENT = 0;

    private static GameSessionSelector instance = null;

    private Map<Id, Game_Session__c> sessionsMap;
    private Set<String> fields = new Set<String>{
        'Id', 'Session_Code__c', 'Current_Step__c'
    };

    public GameSessionSelector() {
        super(OBJECT_NAME);
        this.setFields(this.fields);
    }
    public static GameSessionSelector getInstance() {
        if (instance == null) {
            instance = new GameSessionSelector();
        }
        return instance;
    }
    public Map<Id, Game_Session__c> getContextSessionsAsMapById(Set<Id> ids) {
        if (this.sessionsMap == null) {
            this.sessionsMap = new Map<Id, Game_Session__c>(
                (List<Game_Session__c>)this.selectById(ids)
            );
        }
        return sessionsMap;
    }
    public Map<Id, Game_Session__c> getSessionsAsMapById(Set<Id> ids) {
        return new Map<Id,Game_Session__c>((List<Game_Session__c>)this.selectById(ids));
    }
    public Game_Session__c getRecordById(String id) {
        List<Game_Session__c> sessions = (List<Game_Session__c>)this.selectById(new Set<Id>{(Id)id});
        return sessions.isEmpty() ? null : sessions[FIRST_ELEMENT];
    }
    public Game_Session__c getRecordByConjunction(Map<String,String> conditions) {
        List<Game_Session__c> sessions = (List<Game_Session__c>)this.selectByConjunction(conditions);
        return sessions.isEmpty() ? null : sessions[FIRST_ELEMENT];
    }
}