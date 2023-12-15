public interface DMLUnitOfWork {
    void addDirty(List<sObject> records);
    void addDirty(sObject record);
    void addNew(sObject record);
    void addNew(List<sObject> records);
    void addEvent(List<sObject> events);
    void addEvent(sObject events);
    void commitWork();
}