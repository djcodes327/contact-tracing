@isTest
public class Covid19Test {
  @isTest
  public static void treatPatient() {
    
    // Create an instance of Covid19 Class
    Covid19 jaipur = new Covid19(10);
    
    // Get the number of patients treated in area
    Integer treated = jaipur.getTreated();
    
    // Check wheather the actual count passes match or not.
    System.assertEquals(10, treated, 'Treated count does not match');
    
    // Create an instance of Covid19 Class
    Covid19 hyd = new Covid19(112);
    
    // Get the number of patients treated in area
    treated = hyd.getTreated();
    
    // Check wheather the actual count passes match or not.
    System.assertEquals(112, treated, 'Treated count does not match');
    
    // Check the count of recovered in Country
    System.assertEquals(122, Covid19.recoveredInCountry, 'Treated count for country does not match');
    
    // Testing getTreated
    jaipur.treatPatient();
    treated = jaipur.getTreated();
    
    // Check wheather the actual count passes match or not.
    System.assert(treated == 11, 'Treated count does not match');
    System.assert(Covid19.recoveredInCountry == 123, 'Treated count does not match');
    
  }
  
  @isTest
  public static void treatPatientTestNegative() {
    
    // Create an instance of Covid19 Class
    Covid19 jaipur = new Covid19(-10);
    
    // Get the number of patients treated in area
    Integer treated = jaipur.getTreated();
    
    // Check wheather the actual count passes match or not.
    System.assertEquals(0, treated, 'Treated count does not match');
  }
}