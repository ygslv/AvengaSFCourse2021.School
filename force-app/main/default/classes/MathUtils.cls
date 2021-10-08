public class MathUtils {

    public static Decimal calculateAverage(List<Decimal> nums) {
        
        if (nums.isEmpty()){
            System.debug('List is empty');
            return 1;
        }
        else {
            Decimal sumOfNums = 0;

            for (Decimal currentNum : nums) {
                sumOfNums += currentNum;
            }
    
            return (sumOfNums / nums.size());
        }    
    }
}