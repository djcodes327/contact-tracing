@isTest
private class FitnessTest {
    
    @isTest
    public static void calculateBMIPositiveValues() {
        Decimal resultOne = Fitness.calculateBMI(70, 1.75);
        
        System.assertEquals(22.8571428571428571428571428571429, resultOne, 'BMI Does not match!');
        
        Decimal resultTwo = Fitness.calculateBMI(80, 1.90);
        
        System.assertEquals(22.1606648199445983379501385041551, resultTwo, 'BMI Does not match!');
    }
    
    @isTest
    public static void calculateBMINULLValues() {
        Decimal resultOne = Fitness.calculateBMI(0, 1.75);
        
        System.assertEquals(0, resultOne, 'BMI Should return 0 for NULL Values of Weight');
        
        Decimal resultTwo = Fitness.calculateBMI(80, 0);
        
        System.assertEquals(0, resultTwo, 'BMI Should return 0 for NULL Values of Height');
        
        Decimal resultThree = Fitness.calculateBMI(80, 0);
        
        System.assertEquals(0, resultThree, 'BMI Should return 0 for NULL Values of Height and Weight');
    }
    
    @isTest
    public static void calculateBMINegativeValues() {
        Decimal resultOne = Fitness.calculateBMI(-80, 1.75);
        
        System.assertEquals(0, resultOne, 'BMI Should return 0 for Negative Values of Weight');
        
        Decimal resultTwo = Fitness.calculateBMI(80, -1.75);
        
        System.assertEquals(0, resultTwo, 'BMI Should return 0 for Negative Values of Height');
        
        Decimal resultThree = Fitness.calculateBMI(-80, -1.75);
        
        System.assertEquals(0, resultThree, 'BMI Should return 0 for Negative Values of Height and Weight');
    }
    
    
    // Tests for Calculate Pace
    @isTest
    public static void calculatePacePositiveValues() {
        Decimal resultOne = Fitness.calculatePace(5,60);
        System.debug(resultOne);
        System.assertEquals(5, resultOne, 'Fail');
        
        Decimal resultTwo = Fitness.calculatePace(5,120);
        
        System.assertEquals(2.5, resultTwo, 'Pass');
    }
    
    @isTest
    public static void calculatePaceNULLValues() {
        Decimal resultOne = Fitness.calculatePace(0, 1.75);
        
        System.assertEquals(0, resultOne, 'Pace Should return 0 for NULL Values of Distance');
        
        Decimal resultTwo = Fitness.calculatePace(80, 0);
        
        System.assertEquals(0, resultTwo, 'Pace Should return 0 for NULL Values of Minutes');
        
        Decimal resultThree = Fitness.calculatePace(80, 0);
        
        System.assertEquals(0, resultThree, 'Pace Should return 0 for NULL Values of Distance and Minutes');
    }
    
    @isTest
    public static void calculatePaceNegativeValues() {
        Decimal resultOne = Fitness.calculatePace(-80, 1.75);
        
        System.assertEquals(0, resultOne, 'Pace Should return 0 for Negative Values of Distance');
        
        Decimal resultTwo = Fitness.calculatePace(80, -1.75);
        
        System.assertEquals(0, resultTwo, 'Pace Should return 0 for Negative Values of Minutes');
        
        Decimal resultThree = Fitness.calculatePace(-80, -1.75);
        
        System.assertEquals(0, resultThree, 'Pace Should return 0 for Negative Values of Distance and Minutes');
    }
    
    // GPT Test Classes
    
    // Test for valid inputs
    @isTest
    static void testCalculatePaceValidInputs() {
        Decimal distance = 10; // 10 km
        Decimal minutes = 60; // 60 minutes
        Decimal expectedPace = 10; // expected pace is 10 km/hr
        
        Decimal result = Fitness.calculatePace(distance, minutes);
        
        System.assertEquals(expectedPace, result, 'The pace should return 10km/hr if we pass 10 kms as distance and 60 as minutes.');
    }
    
    // Test when distance is zero
    @isTest
    static void testCalculatePaceDistanceZero() {
        Decimal distance = 0; // 0 km
        Decimal minutes = 60; // 60 minutes
        Decimal expectedPace = 0; // expected pace is 0
        
        Decimal result = Fitness.calculatePace(distance, minutes);
        
        System.assertEquals(expectedPace, result, 'The pace calculation should be 0 when distance is zero');
    }
    
    // Test when minutes is zero
    @isTest
    static void testCalculatePaceMinutesZero() {
        Decimal distance = 10; // 10 km
        Decimal minutes = 0; // 0 minutes
        Decimal expectedPace = 0; // expected pace is 0
        
        Decimal result = Fitness.calculatePace(distance, minutes);
        
        System.assertEquals(expectedPace, result, 'The pace calculation should be 0 when minutes is zero');
    }
    
    // Test when distance is negative
    @isTest
    static void testCalculatePaceDistanceNegative() {
        Decimal distance = -10; // -10 km
        Decimal minutes = 60; // 60 minutes
        Decimal expectedPace = 0; // expected pace is 0
        
        Decimal result = Fitness.calculatePace(distance, minutes);
        
        System.assertEquals(expectedPace, result, 'The pace calculation should be 0 when distance is negative');
    }
    
    // Test when minutes is negative
    @isTest
    static void testCalculatePaceMinutesNegative() {
        Decimal distance = 10; // 10 km
        Decimal minutes = -60; // -60 minutes
        Decimal expectedPace = 0; // expected pace is 0
        
        Decimal result = Fitness.calculatePace(distance, minutes);
        
        System.assertEquals(expectedPace, result, 'The pace calculation should be 0 when minutes is negative');
    }

    public static void updateAccountTestMethod(List<Opportunity> Oppty) {
        Update Oppty;
    }
    
}