// Ch. 9 exercises — fizzbuzz, the subject of the draw-a-CFG exercise.
public class Fizzbuzz {
  static String fizzbuzz(int n) {
    if (n % 15 == 0) {
      return "FizzBuzz";
    } else if (n % 3 == 0) {
      return "Fizz";
    } else if (n % 5 == 0) {
      return "Buzz";
    } else {
      return String.valueOf(n);
    }
  }

  public static void main(String[] args) {
    assert fizzbuzz(15).equals("FizzBuzz");
    assert fizzbuzz(9).equals("Fizz");
    assert fizzbuzz(10).equals("Buzz");
    assert fizzbuzz(7).equals("7");
    System.out.println("fizzbuzz exercise example ok");
  }
}
