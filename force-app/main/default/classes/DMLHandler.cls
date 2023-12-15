public class DMLHandler implements DMLUnitOfWork {
    /* **********************
    ** Private variables
    ** ************************* */
    private Map<Id, sObject> recordsForUpdate;
    private Map<Id, sObject> recordsForInsert;
    private Map<Id, sObject> recordsForDelete;
    private List<sObject> eventsToPublish;
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
        if (recordsForUpdate != null && !recordsForUpdate.isEmpty()) updateRecords(recordsForUpdate.values());
        if (eventsToPublish != null && !eventsToPublish.isEmpty()) publishEvents(eventsToPublish);
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
    ** Method Name: publishEvents
    ** Description: runs publishing of events
    ** Parameters: List<sObject>
    ** Returns: void
    ** ********************************************* */   
    private void publishEvents(List<sObject> records) {
        EventBus.publish(records);
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
        if (records != null && !records.isEmpty()) {
            if (recordsForUpdate == null) {
                recordsForUpdate = new Map<Id, sObject>(); 
            }
            for (sObject record : records) {
                recordsForUpdate.put(record.Id, record);
            }
        }
    }

    /* *********************************************
    ** Method Name: addDirty
    ** Description: adds dirty records for update
    ** Parameters: sObject
    ** Returns: void
    ** ********************************************* */   
    public void addDirty(sObject record) {
        if (record != null) {
            if (recordsForUpdate == null) {
                recordsForUpdate = new Map<Id, sObject>(); 
            }
            recordsForUpdate.put(record.Id, record);   
        }
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
    ** Method Name: addEvent
    ** Description: adds new events to publish
    ** Parameters: List<sObject>
    ** Returns: void
    ** ********************************************* */   
    public void addEvent(List<sObject> events) {
        if (events != null && !events.isEmpty()) {
            if (eventsToPublish == null) {
                eventsToPublish = new List<sObject>(); 
            }
            eventsToPublish.addAll(events);
        }
    }

    /* *********************************************
    ** Method Name: addEvent
    ** Description: adds new event to publish
    ** Parameters: sObject
    ** Returns: void
    ** ********************************************* */   
    public void addEvent(sObject event) {
        if (event != null) {
            if (eventsToPublish == null) {
                eventsToPublish = new List<sObject>(); 
            }
            eventsToPublish.add(event);
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

    public List<sObject> returnInsertedList() {
        return this.recordsForInsert.values();
    }
}