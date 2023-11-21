public class DMLHandler implements DMLUnitOfWork {
    /* **********************
    ** Private variables
    ** ************************* */
    private Map<Id, sObject> recordsForUpdate;
    private Map<Id, sObject> recordsForInsert;
    private Map<Id, sObject> recordsForDelete;
    private static DMLHandler instance;
    
	/* **********************
    ** Private methods
    ** ********************** */

    /* *********************************************
    ** Method Name: makeDML
    ** Description: runs DML operations
    ** Parameters: no
    ** Returns: void
    ** ********************************************* */   
    private void makeDML() {
        if (recordsForInsert != null && !recordsForInsert.isEmpty()) insertRecords(recordsForInsert.values());
    }

    /* *********************************************
    ** Method Name: updateRecords
    ** Description: runs update
    ** Parameters: List<sObject>
    ** Returns: void
    ** ********************************************* */   
    private void updateRecords(List<sObject> records) {
        update records;
    }
    
    /* *********************************************
    ** Method Name: insertRecords
    ** Description: runs insert
    ** Parameters: List<sObject>
    ** Returns: void
    ** ********************************************* */   
    private void insertRecords(List<sObject> records) {
        insert records;
    }
    
    /* *********************************************
    ** Method Name: deleteRecords
    ** Description: performs delete
    ** Parameters: List<sObject>
    ** Returns: void
    ** ********************************************* */   
    private void deleteRecords(List<sObject> records) {
        delete records;
    }
    
	/* **********************
    ** Public methods
    ** ********************** */

    /* *********************************************
    ** Method Name: getInstance
    ** Description: returns a single instance
    ** Parameters: no
    ** Returns: DMLHandler
    ** ********************************************* */   
    public static DMLHandler getInstance() {
        if (instance == null) {
            instance = new DMLHandler();
        }
        return instance;
    }
    
    /* *********************************************
    ** Method Name: addDirty
    ** Description: adds dirty records for update
    ** Parameters: List<sObject>s
    ** Returns: void
    ** ********************************************* */   
    public void addDirty(List<sObject> records) {
        
    }

    /* *********************************************
    ** Method Name: addDirty
    ** Description: adds dirty records for update
    ** Parameters: sObject
    ** Returns: void
    ** ********************************************* */   
    public void addDirty(sObject record) {
        
    }

    /* *********************************************
    ** Method Name: addNew
    ** Description: adds new records for insert
    ** Parameters: sObject
    ** Returns: void
    ** ********************************************* */   
    public void addNew(sObject record) {
        if (record != null) {
            if (recordsForInsert == null) {
                recordsForInsert = new Map<Id, sObject>(); 
            }
            recordsForInsert.put(record.Id, record);   
        }
    }

    /* *********************************************
    ** Method Name: addNew
    ** Description: adds new records before insert
    ** Parameters: List<sObject>
    ** Returns: void
    ** ********************************************* */   
    public void addNew(List<sObject> records) {
        if (records != null && !records.isEmpty()) {
            if (recordsForInsert == null) {
                recordsForInsert = new Map<Id, sObject>(); 
            }
            for (sObject record : records) {
                recordsForInsert.put(record.Id, record);
            }
        }
    }
    
    /* *********************************************
    ** Method Name: commitWork
    ** Description: runs makeDML and controls the transaction
    ** Parameters: no
    ** Returns: void
    ** ********************************************* */   
    public void commitWork() {
        Savepoint sp = Database.setSavepoint();
        try
        {
            makeDML();
        } catch (Exception e) {
            Database.rollback(sp);
            throw e;
        } finally {
            
        }
    }
}