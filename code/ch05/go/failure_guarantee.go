// Chapter 5, §5.3.1 — the failure postcondition of "Withdraw Cash from ATM" as a test:
// no money out without a matching debit, even when the authorization link drops (B1).
package main

import (
	"errors"
	"fmt"
)

type LostLinkBank struct{ debits []int }           // the fake — the link drops at step 8
func (b *LostLinkBank) authorize(amount int) error { return errors.New("link lost") }

type Atm struct{ dispensed int }   // cash actually dispensed
func (a *Atm) dispense(amount int) { a.dispensed += amount }

func withdraw(atm *Atm, bank *LostLinkBank, amount int) { // steps 8–11 of the basic flow
	if err := bank.authorize(amount); err != nil {
		return // B1 — cancel, return the card
	}
	atm.dispense(amount)
	bank.debits = append(bank.debits, amount)
}

func main() {
	atm, bank := &Atm{}, &LostLinkBank{}
	withdraw(atm, bank, 200)
	if atm.dispensed != 0 || len(bank.debits) != 0 { // the failure postcondition, verbatim
		panic("failure postcondition violated")
	}
	fmt.Println("failure guarantee holds: no cash dispensed, no debit recorded")
}
