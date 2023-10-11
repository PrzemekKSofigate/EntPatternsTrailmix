public with sharing class CaseService {
  private static final String STATUS_CLOSED = 'Closed';

  public static void closeCases(Set<Id> caseIds, String closeReason) {
    List<Case> records = new List<Case>();
    for (Id recordId : caseIds) {
      records.add(buildClosedCaseRecord(recordId, closeReason));
    }
    update records;
  }

  private static Case buildClosedCaseRecord(Id caseId, String closeReason) {
    return new Case(Id = caseId, Status = STATUS_CLOSED, Reason = closeReason);
  }
}
