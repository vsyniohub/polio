public virtual class Selector {
    private String objectName;
    private Set<String> fields = new Set<String>{
        'Id'
    };

    public Selector(String objectName) {
        this.objectName = objectName;
    }
    public virtual Selector setFields(Set<String> newFields) {
        this.fields = newFields;
        return this;
    }
    public virtual List<sObject> selectById(Set<Id> ids) {
        String query = getBaseQuery() + 'WHERE Id in :ids';
        return Database.query(query);
    }
    public virtual List<sObject> selectByConjunction(Map<String, String> conditions) {
        String query = getBaseQuery() + 'WHERE ' + generateConditions(conditions);
        return Database.query(query);
    }
    
    private String getBaseQuery() {
        return 
            'SELECT ' + String.join((Iterable<String>)this.fields, ', ') + ' ' + 
            'FROM ' + this.objectName + ' ';
    }
    private String generateConditions(Map<String, String> conditions) {
        String whereClause = '';
        for (String field : conditions.keySet()) {
            whereClause += field + ' = \'' + conditions.get(field) + '\' AND ' ;
        }
        return whereClause.removeEnd('AND ');
    }
}