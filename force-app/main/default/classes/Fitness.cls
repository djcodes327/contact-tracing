public class Fitness {
    
    /**
     * calculateBMI method
     * accepts body weight (should be in kg's)
     * and body height (should be in meter)
     * return's BMI Value
     */
    public static Decimal calculateBMI(Decimal weight, Decimal height) {
        Decimal result = 0;
        if (weight <= 0 || height <= 0) {
            return result = 0;
        } else {
            result = weight / (height * height);
            return result;
        }
    }
    
    /**
     * calculatePace method
     * accepts distance (should be in km)
     * and minutes
     * return's pace
     */
    
    public static Decimal calculatePace(Decimal distance, Decimal minutes){
        Decimal pace = 0;
        if(distance <= 0 || minutes <= 0) {
            return pace;
        } else {
            Decimal hr = minutes/60;
            pace = distance/hr;
            return pace;
        }
    }
}