public virtual class Selector {
    private final static Integer FIRST_ELEMENT = 0;
    
    private String objectName;
    private String finalQuery;

    protected Set<String> fields = new Set<String>{
        'Id'
    };
    protected Map<String,Set<String>> childObjectFields = new Map<String,Set<String>> {
        'Game_Units__r' => fields
    };

    public Selector(String objectName) {
        this.objectName = objectName;
    }

    public virtual Selector setFields(Set<String> newFields) {
        this.fields = newFields;
        return this;
    }
    public virtual Selector setChildFields(Map<String,Set<String>> childObjectFields){ //relationship vs fields
        this.childObjectFields = childObjectFields;
        return this;
    }
    public virtual List<sObject> selectById(Set<Id> ids) {
        String query = getBaseQuery() + 'WHERE Id in :ids';
        return Database.query(query);
    }
    public virtual List<sObject> selectByConjunction(Map<String, String> conditions) {
        String query = getBaseQuery() + 'WHERE ' + generateConditions(conditions);
        this.finalQuery = query;
        return Database.query(query);
    }

    public String getFinalQuery() {
        return this.finalQuery;
    }

    protected virtual String getBaseQuery() {
        return 
            'SELECT ' + String.join((Iterable<String>)this.fields, ', ') + getChildQueries() + ' ' + 
            'FROM ' + this.objectName + ' ';
    }
    protected virtual String getChildQueries() {
        String childSubQuery = '';
        for (String sObjectName : this.childObjectFields.keySet()) {
            String query = '' + 
                ',(SELECT ' + String.join((Iterable<String>)this.childObjectFields.get(sObjectName), ', ') + ' ' + 
                'FROM ' + sObjectName + '),';
            childSubQuery += query;
        }
        return childSubQuery.removeEnd(',');
    }
    protected String generateConditions(Map<String, String> conditions) {
        String whereClause = '';
        for (String field : conditions.keySet()) {
            whereClause += field + ' = \'' + conditions.get(field) + '\' AND ' ;
        }
        return whereClause.removeEnd('AND ');
    }
}