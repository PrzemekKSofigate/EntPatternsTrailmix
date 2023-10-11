@isTest
public with sharing class UnitOfWorkTest {
    
    @isTest
    public static void challengeComplete() {
        fflib_SObjectUnitOfWork unitOfWork = new fflib_SObjectUnitOfWork(
            new List<Schema.SObjectType> {
                Account.getSObjectType(),
                Contact.getSObjectType(),
                Note.getSObjectType()
            }
        );

        for (Integer i = 0; i < 100; i++) {
            Account accRecord = new Account();
            accRecord.Name = 'Test Account ' + i;
            unitOfWork.registerNew(accRecord);

            for (Integer j = 0; j < 5; j++) {
                Contact conRecord = new Contact();
                conRecord.LastName = 'Test Cont ' + i + ' - ' + j;
                unitOfWork.registerNew(conRecord, Contact.AccountId, accRecord);

                Note noteRecord = new Note();
                noteRecord.Title = 'Note ' + i + ' - ' + j;
                unitOfWork.registerNew(noteRecord, Note.ParentId, accRecord);
            }
        }
        unitOfWork.commitWork();

        System.assertEquals(100, [Select Id from Account].size());
        System.assertEquals(500, [Select Id from Contact].size());
        System.assertEquals(500, [Select Id from Note].size());
    }
}