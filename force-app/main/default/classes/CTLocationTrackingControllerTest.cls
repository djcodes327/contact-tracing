@isTest
private class CTLocationTrackingControllerTest {
  
  @isTest
  public static void testCheckDuplicates() {
    User usr = createTestUser();
    
    Location_Tracing__c locTrace1 = new Location_Tracing__c();
    locTrace1.Location__c = [SELECT Id FROM Location__c WHERE Name = 'Test Location 1'].Id;
    locTrace1.Person__c = [SELECT Id FROM Person__c WHERE Name = 'Test Person 1'].Id;
    
    Location_Tracing__c locTrace2 = new Location_Tracing__c();
    locTrace2.Location__c = [SELECT Id FROM Location__c WHERE Name = 'Test Location 1'].Id;
    locTrace2.Person__c = [SELECT Id FROM Person__c WHERE Name = 'Test Person 2'].Id;
    
    List<Location_Tracing__c> newLocationTraces = new List<Location_Tracing__c>{
      locTrace1,
      locTrace2
    };
    
    System.runAs(usr) {
      Test.startTest();
      List<Location_Tracing__c> duplicates = CTLocationTracingController.checkDuplicates(newLocationTraces);
      Test.stopTest();
      
      System.assertEquals(2, duplicates.size());
    }
  }
}