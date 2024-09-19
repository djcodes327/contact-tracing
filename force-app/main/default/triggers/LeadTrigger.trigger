trigger LeadTrigger on Lead (before insert, before update) {
  System.debug('Inside Lead Trigger');
  for(Lead leadRecord: Trigger.New) {
    if(String.isBlank(leadRecord.LeadSource)) {
      leadRecord.addError('Lead Source Cannot be blank');
    }
  }
}