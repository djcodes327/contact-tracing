public class OpportunityUpdate {
  
  public static void updateOpportunityProfile(List<Opportunity> opptys) {
    // Iterate over each opportunity in the list
    for (Opportunity opportunity: opptys) {
      if (opportunity.Amount < 10000) {
        opportunity.Profile__c = 'Low';
      } else if (opportunity.Amount >= 10000 && opportunity.Amount < 50000) {
        opportunity.Profile__c = 'Medium';
      } else if (opportunity.Amount >= 50000) {
        opportunity.Profile__c = 'High';
      }
    }
    
    // Update all opportunities after setting the Profile__c field
    update opptys;
  }
}