public class CTLocationTrackingController {
  /**
   * @description Queries the Location Tracing records and returns them.
   * @Date 5 August 2024
   * @param locationId String
   * @return List<Location_Tracing__c>
   */
  public static List<Location_Tracing__c> getVisitors(String locationId) {
    List<Location_Tracing__c> visitors = [
      SELECT
        ID,
        Name,
        Person__c,
        Location__c,
        Visit_Date__c,
        Person__r.Token__c,
        Person__r.Health_Status__c
      FROM Location_Tracing__c
      WHERE ID = :locationId
      ORDER BY Visit_Date__c DESC NULLS LAST
    ];
    
    return visitors;
  }
  
  /**
   * @description Queries Location tracing records where Person matches the "PersonIds"
   * @Date 5 August 2024
   * @param personIds Set<String>
   * @return List<Location_Tracing__c>
   */
  public static List<Location_Tracing__c> getLocationsByPersonIds(Set<String> personIds) {
    List<Location_Tracing__c> locations = [
      SELECT Id, Name, Person__c, Location__c
      FROM Location_Tracing__c
      WHERE Person__c IN :personIds 
      AND Visit_Date__c = LAST_N_DAYS:10
    ];
    return locations;
  }
  
  /**
   * @description Queries Location tracing records where Location matches the "locationIds"
   * @Date 5 August 2024
   * @param personIds Set<String>
   * @return List<Location_Tracing__c>
   */
  public static List<Location_Tracing__c> getLocationsByLocationIds(Set<String> locationIds) {
    List<Location_Tracing__c> locations = [
      SELECT Id, Name, Person__c, Location__c
      FROM Location_Tracing__c
      WHERE Location__c IN :locationIds AND Person__r.Health_Status__c = 'Green'
    ];
    return locations;
  }
  
  /**
   * @description Queries Location tracing and return duplicates if found in locationTraces
   * @Date 15 September 2024
   * @param List<Location_Tracing__c> locationTraces
   * @return List<Location_Tracing__c>
   */
  
  public static List<Location_Tracing__c> checkDuplicates(List<Location_Tracing__c> newLocationTraces) {
    
    // Step 1: Iterate over the new locationTraces records and get unique locationIds and personIds
    Set<Id> locationIds = new Set<Id>();
    Set<Id> personIds = new Set<Id>();
    
    for (Location_Tracing__c locationTrace : newLocationTraces) {
      locationIds.add(locationTrace.Location__c);
      personIds.add(locationTrace.Person__c);
    }
    
    // Step 2: Query Exisiting Location Tracing records using the locationIds and personIds collected in Step 1.
    List<Location_Tracing__c> existingRecords = [
      SELECT Id, Name, Person__c, Location__c
      FROM Location_Tracing__c
      WHERE Location__c IN :locationIds
      AND Person__c IN :personIds
    ];
    
    System.debug('Existing Records : ' + existingRecords);
    
    // Step 3:
    // Map of LocationIds and Set of PersonIds
    Map<Id, Set<Id>> mapOfExistingRecords = new Map<Id, Set<Id>>();
    
    if(existingRecords != null && existingRecords.size() > 0) {
      for (Location_Tracing__c record: existingRecords) {
        if (!mapOfExistingRecords.containsKey(record.Location__c)) {
          mapOfExistingRecords.put(record.Location__c, new Set<Id>());
        }
        mapOfExistingRecords.get(record.Location__c).add(record.Person__c);
      }
    }
    
    System.debug('Map Existing Records : ' + mapOfExistingRecords);
    
    List<Location_Tracing__c> duplicates = new List<Location_Tracing__c>();
    
    for(Location_Tracing__c newLocationTrace: newLocationTraces) {
      if(mapOfExistingRecords.containsKey(newLocationTrace.Location__c)
      && mapOfExistingRecords.get(newLocationTrace.Location__c).contains(newLocationTrace.Person__c)) {
        duplicates.add(newLocationTrace);
      }
    }
    
    return duplicates;
  }
  
}