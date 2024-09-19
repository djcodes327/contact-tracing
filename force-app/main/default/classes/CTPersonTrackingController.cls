public class CTPersonTrackingController {
  
  /**
   * @description Queries People Tracing Records matching "recordId" Value
   * @Date 15 September 2024
   * @param String recordId
   * @return List<People_Tracing__c>
   */
  public static List<People_Tracing__c> getTraces(String recordId) {
    return [
          SELECT Id, Name, Person_1__c, Person_1__r.Health_Status__c, Person_1__r.Token__c, 
                 Person_2__c, Person_2__r.Health_Status__c, Person_2__r.Token__c, 
                 Contact_Type__c, Contact_Date__c
          FROM People_Tracing__c
          WHERE Person_1__c = :recordId 
          OR Person_2__c = :recordId
          ORDER BY Contact_Date__c
      ];
  }
  
  /**
   * @description Checks for duplicate People Tracing records based on Person_1__c and Person_2__c fields.
   * @param List<People_Tracing__c> newPeopleTraces
   * @return List<People_Tracing__c> - List of duplicate records
   */
  public static List<People_Tracing__c> checkDuplicates(List<People_Tracing__c> newPeopleTraces) {
    
    // Unique Person IDs
    Set<Id> personIds = new Set<Id>();
    for (People_Tracing__c newTrace : newPeopleTraces) {
      personIds.add(newTrace.Person_1__c);
      personIds.add(newTrace.Person_2__c);
    }
    
    // List of Duplicate Records
    List<People_Tracing__c> duplicateRecords = new List<People_Tracing__c>();
    
    // Map of Person Ids and corresponding set of connected Person Ids
    Map<Id, Set<Id>> mapOfExistingRecords = new Map<Id, Set<Id>>();
    
    // List of Existing Person Tracing records
    List<People_Tracing__c> existingRecords = [
          SELECT Id, Person_1__c, Person_2__c
          FROM People_Tracing__c
          WHERE Person_1__c IN :personIds OR Person_2__c IN :personIds
      ];
    
    // Check if existingRecords exist and then compare with new records
    if (existingRecords != null && existingRecords.size() > 0) {
      for (People_Tracing__c existingTrace : existingRecords) {
        // Build Map for Person 1
        if (!mapOfExistingRecords.containsKey(existingTrace.Person_1__c)) {
          mapOfExistingRecords.put(existingTrace.Person_1__c, new Set<Id>());
        }
        mapOfExistingRecords.get(existingTrace.Person_1__c).add(existingTrace.Person_2__c);
        
        // Build Map for Person 2
        if (!mapOfExistingRecords.containsKey(existingTrace.Person_2__c)) {
          mapOfExistingRecords.put(existingTrace.Person_2__c, new Set<Id>());
        }
        mapOfExistingRecords.get(existingTrace.Person_2__c).add(existingTrace.Person_1__c);
      }
      
      // Check for Duplicates.
      for (People_Tracing__c trace : newPeopleTraces) {
        if (
          (mapOfExistingRecords.containsKey(trace.Person_1__c) && mapOfExistingRecords.get(trace.Person_1__c).contains(trace.Person_2__c))
          ||
          (mapOfExistingRecords.containsKey(trace.Person_2__c) && mapOfExistingRecords.get(trace.Person_2__c).contains(trace.Person_1__c))
        ) {
          duplicateRecords.add(trace);
        }
      }
    }
    
    // Return the list of duplicate records, or an empty list if no duplicates found
    return duplicateRecords;
  }
}