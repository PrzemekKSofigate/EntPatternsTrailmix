public with sharing class AccountsSelector extends fflib_SObjectSelector {
	public List<Schema.SObjectField> getSObjectFieldList() {
		return new List<Schema.SObjectField>{
			Account.Id,
			Account.AnnualRevenue,
			Account.Description,
			Account.Name
		};
	}

	public Schema.SObjectType getSObjectType() {
		return Account.SObjectType;
	}

	public List<Account> selectById(Set<Id> idSet) {
		return (List<Account>) selectSObjectsById(idSet);
	}
}
