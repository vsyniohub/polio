public with sharing class GameUnitSelector extends Selector {
    private final static String OBJECT_NAME = 'Game_Unit__c';

    private static GameUnitSelector instance = null;

    private Set<String> fields = new Set<String>{
        'Id', 'Title__c', 'Content__c', 'Status__c', 'Duration__c', 'Responses_Left__c', 'Game_Session__r.Participants_Joined__c'
    };
    private Map<String, Set<String>> childUnitsFields = new Map<String, Set<String>> {
        'Unit_Items__r' => new Set<String>{'Answer__c'}
    };

    public GameUnitSelector() {
        super(OBJECT_NAME);
        this.setFields(this.fields);
        this.setChildFields(this.childUnitsFields);
    }

    public static GameUnitSelector getInstance() {
        if (instance == null) {
            instance = new GameUnitSelector();
        }
        return instance;
    }
    public List<Game_Unit__c> getRecordsByConjunction(Map<String,String> conditions) {
        List<Game_Unit__c> units = (List<Game_Unit__c>)this.selectByConjunction(conditions);
        return units.isEmpty() ? null : units;
    }
    public Game_Unit__c getRecordById(String id) {
        List<Game_Unit__c> units = (List<Game_Unit__c>)this.selectById(new Set<Id>{(Id)id});
        return units.isEmpty() ? null : units[FIRST_ELEMENT];
    }
}