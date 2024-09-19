public with sharing class AccountController {
  
  public Account insertAccount(Account acc) {
    insert acc;
    return acc;
  }
  
  public List<Account> insertAccounts(List<Account> accs) {
    insert accs;
    return accs;
  }
  
  public static Account getAccountByID(String id) {
    try {
      Account acc = [SELECT ID,Name from Account WHERE ID = :id];
      return acc;
    } catch (Exception e) {
      System.debug('Exception : '+e);
      return null;
    }
  }
  
  public static List<Account> listAllAccounts() {
    try {
      List<Account> accounts = [SELECT ID,Name from Account LIMIT 10];
      return accounts;
    } catch (Exception e) {
      System.debug('Exception : '+e);
      return null;
    }
  }
  
  public static void printAllAccounts() {
    List<Account> accounts = listAllAccounts();
    if(accounts.size() >0) {
      for(Account account : accounts) {
        System.debug('Account ID : '+account.Id+' Account Name : '+account.Name);
      }
    } else {
      System.debug('No Account Found');
    }
  }
  
  public static void updateAvgCaseResolutionDays(List<Account> accountIds){
    Integer totalDays = 0;
    Integer totalCases = 0;
    // retrive all the cases for this account
    // get resolution days for each account (ClosedDate - CreatedDate)
    for(Case caseObj : [SELECT Id, CreatedDate, ClosedDate
                         FROM Case
                         WHERE IsClosed=true
                          AND AccountId IN: accountIds]){
      // increase number of cases
      totalCases++;
      // get duration in days and add it to totalDays
      totalDays += caseObj.CreatedDate.date().daysBetween(caseObj.ClosedDate.date());
    }
    Decimal resolutionDays = totalDays/totalCases;
    // update account object
    // Account acc = new Account(Id=accountId, Avg_Case_Resolution_Days__c = resolutionDays);
    update accountIds;
  }
  
  public static void updateAccountsAvgCaseResolutionDays(List<Id> accountIds) {
    Map<Id,Integer> accountTotalCaseMap = new Map<Id,Integer>();
    Map<Id,Integer> accountTotalCaseDaysMap = new Map<Id,Integer>();
    
    for(Case caseObj: [SELECT ID,CreatedDate,ClosedDate,AccountId FROM Case WHERE IsClosed=true AND AccountId IN: accountIds]) {
      
      // Check if the Map already contains that accountId or not.
      if(!accountTotalCaseMap.containsKey(caseObj.AccountId)) {
        accountTotalCaseMap.put(caseObj.AccountId, 0);
        accountTotalCaseDaysMap.put(caseObj.AccountId, 0);
      }
      
      Integer totalCases = accountTotalCaseDaysMap.get(caseObj.AccountId);
      totalCases ++;
      accountTotalCaseDaysMap.put(caseObj.AccountId, totalCases);
      
      Integer totalCaseDays = accountTotalCaseDaysMap.get(caseObj.AccountId);
      totalCaseDays += caseObj.CreatedDate.date().daysBetween(caseObj.ClosedDate.date());
      accountTotalCaseDaysMap.put(caseObj.AccountId, totalCaseDays);
      
    }
    
    List<Account> accountToUpdate = new List<Account>();
    for(Id accountId:accountTotalCaseMap.keySet()) {
      Decimal resolutionDays = accountTotalCaseDaysMap.get(accountId)/accountTotalCaseMap.get(accountId);
      accountToUpdate.add(new Account(Id=accountId, Avg_Case_Resolution_Days__c=resolutionDays));
    }
    
    update accountToUpdate;
  }
  
}