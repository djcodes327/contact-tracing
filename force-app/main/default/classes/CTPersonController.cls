public class CTPersonController {
  /*
   * getToken()
   * Accepts a String argument (Mobile Number)
   * It Generates a secure MD5 Token using MD5 hashing
   * returns the secure token back to caller
   */
  public static String getToken(String mobile) {
    Blob targetBlob = Blob.valueOf(mobile);
    Blob hash = Crypto.generateDigest('MD5', targetBlob);
    String result = EncodingUtil.base64Encode(hash);
    System.debug('Value: ' + result);
    return result;
  }
  /**
   * getRecentHealthChanges()
   * Gets Last 100 records where status field was updated.
   * @return returns List of persons.
   */
  public static List<Person__c> getRecentHealthChanges() {
    List<Person__c> persons = [
      SELECT Id, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c
      FROM Person__c
      ORDER BY Status_Update_Date__c DESC NULLS LAST
      LIMIT 100
    ];
    return persons;
  }
  /**
   * searchPeople(String searchTerm)
   * Searches for Person__c records by name, mobile number, or token.
   *
   * @param searchTerm The term to search for in the Name, Mobile_Number__c, or Token__c fields.
   * @return A list of Person__c records that match the search criteria.
   */
  public static List<Person__c> searchPeople(String searchTerm) {
    List<Person__c> persons = [
      SELECT
        Id,
        Name,
        Health_Status__c,
        Mobile__c,
        Status_Update_Date__c,
        Token__c
      FROM Person__c
      WHERE
        Name LIKE :('%' + searchTerm + '%')
        OR Mobile__c LIKE :('%' + searchTerm + '%')
        OR Token__c LIKE :('%' + searchTerm + '%')
    ];
    System.debug('Persons : ' + persons);
    return persons;
  }
  
  /**
   * getPersonById(String personId)
   * Searches for Person__c records by personId.
   *
   * @param personId The term to search for in the Id fields.
   * @return A list of Person__c records that match the search criteria.
   */
  public static Person__c getPersonById(String personId) {
    List<Person__c> person = [
      SELECT
        Id,
        Name,
        Health_Status__c,
        Mobile__c,
        Status_Update_Date__c,
        Token__c
      FROM Person__c
      WHERE ID = :personId
    ];
    System.debug('Person : ' + person);
    if (person != null && person.size() > 0) {
      return person[0];
    }
    return null;
  }
  
  /**
   * getHealthStatusCount()
   * Searches for Person__c records by Health Status.
   *
   * @return Map<String, Integer> with count of people in each status.
   */
  public static Map<String, Integer> getHealthStatusCount() {
    Map<String, Integer> healthStatusCount = new Map<String, Integer>();
    for(AggregateResult result: [
      SELECT Health_Status__c, Count(ID) countOfPeople
      FROM Person__c
      GROUP BY Health_Status__c
    ]) {
      healthStatusCount.put((String)result.get('Health_Status__c'), (Integer)result.get('countOfPeople'));
    }
    return healthStatusCount;
  }
}