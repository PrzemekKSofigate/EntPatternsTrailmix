public with sharing class Accounts extends fflib_SObjectDomain {
	private static final String DEFAULT_DESCRIPTION = 'Domain classes rock!';

	public Accounts(List<Account> sObjectList) {
		super(sObjectList);
	}

	public override void onApplyDefaults() {
		setDefaultDescription();
	}

	public override void onBeforeUpdate(Map<Id, SObject> existingRecords) {
		calculateLevenshtein();
	}

	private void setDefaultDescription() {
		for (Account acc : (List<Account>) records) {
			acc.Description = DEFAULT_DESCRIPTION;
		}
	}

	private void calculateLevenshtein() {
		for (Account acc : (List<Account>) records) {
			acc.AnnualRevenue = DEFAULT_DESCRIPTION.getLevenshteinDistance(
				acc.Description
			);
		}
	}

	public class Constructor implements fflib_SObjectDomain.IConstructable {
		public fflib_SObjectDomain construct(List<SObject> sObjectList) {
			return new Accounts(sObjectList);
		}
	}
}
