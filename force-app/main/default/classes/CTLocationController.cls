public class CTLocationController {
  /**
   * getRecentStatusChanges()
   * Gets Last 100 location records where status field was updated.
   * @return returns List of Locations.
   */
  
  public static List<Location__c> getRecentStatusChanges() {
    List<Location__c> locations = [
      SELECT
        Name,
        Address__c,
        Pincode__c,
        Red_Score__c,
        Status_Update_Date__c,
        Status__c
      FROM Location__c
      ORDER BY Status_Update_Date__c DESC NULLS LAST
      LIMIT 100
    ];
    return locations;
  }
  
  /**
   * searchLocations(String searchTerm)
   * Searches for Location__c records by name, pincode, or Address.
   *
   * @param searchTerm The term to search for in the Name, Pincode__c, or Address__c fields.
   * @return A list of Location__c records that match the search criteria.
   */
  public static List<Location__c> searchLocations(String searchTerm) {
    List<Location__c> locations = [
      SELECT
        Id,
        Address__c,
        Pincode__c,
        Red_Score__c,
        Status_Update_Date__c,
        Status__c
      FROM Location__c
      WHERE
        Name LIKE :('%' + searchTerm + '%')
        OR Pincode__c LIKE :('%' + searchTerm + '%')
        OR Address__c LIKE :('%' + searchTerm + '%')
    ];
    
    return locations;
  }
  
  /**
   * getLocationById(String locationId)
   * Searches for Location__c records by personId.
   *
   * @param locationId The term to search for in the Id fields.
   * @return Location__c record that match the search criteria.
   */
  public static Location__c getLocationById(String locationId) {
    List<Location__c> location = [
      SELECT
        Id,
        Name,
        Address__c,
        Pincode__c,
        Red_Score__c,
        Status_Update_Date__c,
        Status__c
      FROM Location__c
      WHERE ID = :locationId
    ];
    if (location != null && location.size() > 0) {
      return location[0];
    }
    return null;
  }
  
  /**
   * getStatusCount()
   * Searches for Location__c records by  Status__c.
   *
   * @return Map<String, Integer> with count of Location in each status.
   */
  public static Map<String, Integer> getStatusCount() {
    Map<String, Integer> statusCount = new Map<String, Integer>();
    for(AggregateResult result: [
      SELECT Status__c, Count(ID) countOfLocation
      FROM Location__c
      GROUP BY Status__c
    ]) {
      statusCount.put((String)result.get('Status__c'), (Integer)result.get('countOfLocation'));
    }
    return statusCount;
  }
}