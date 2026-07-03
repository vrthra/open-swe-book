// Ch. 9 exercises — sanity checks for the fizzbuzz CFG exercise.
package discount

import "testing"

func TestFizzbuzz(t *testing.T) {
	cases := map[int]string{15: "FizzBuzz", 9: "Fizz", 10: "Buzz", 7: "7"}
	for n, want := range cases {
		if got := fizzbuzz(n); got != want {
			t.Errorf("fizzbuzz(%d) = %q, want %q", n, got, want)
		}
	}
}
