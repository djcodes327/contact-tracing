public class TestApexClass {
    
    // Public constructor
    public TestApexClass() {
        System.debug('Entering Test Apex Class!');
        Map<Integer,String> class2020 = new Map<Integer,String>();
        // Adding Items to Map
        class2020.put(100, 'Deep Joshi');
        class2020.put(101, 'Swati');
        class2020.put(102, 'Harsh');
        
        System.debug(class2020);
    }
    
    // Private method with a parameter
    private void printMessage(String message) {
        System.debug('Message: ' + message);
    }
    
    // Public method with return value
    public Integer addNumbers(Integer a, Integer b) {
        return a + b;
    }
    
    // Static method
    public static void sayHello() {
        System.debug('Hello from static method!');
    }
    
    // Global method
    // global void displayMessage() {
        //     System.debug('This is a global method in TestApexClass.');
    // }
    
    // Method with custom object as parameter
    public void processAccount(Account acc) {
        System.debug('Processing account: ' + acc.Name);
    }
}