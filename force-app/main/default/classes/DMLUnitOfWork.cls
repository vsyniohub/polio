public interface DMLUnitOfWork {
    void addDirty(List<sObject> records);
    void addDirty(sObject record);
    void addNew(sObject record);
    void addNew(List<sObject> records);
    void commitWork();
}