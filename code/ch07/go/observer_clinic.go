// §7.2.2 Observers and Subscribers — a subject that notifies without knowing
// its observers' concrete types (clinic scheduler: waiting-room display).
package main

import "fmt"

type Observer func(*Appointment)

type Appointment struct {
	Status    string
	observers []Observer
}

func (a *Appointment) Subscribe(observer Observer) {
	a.observers = append(a.observers, observer)
}

func (a *Appointment) SetStatus(newStatus string) {
	a.Status = newStatus
	for _, notify := range a.observers { // any Observer func will do
		notify(a)
	}
}

func main() {
	appt := &Appointment{Status: "booked"}
	appt.Subscribe(func(a *Appointment) {
		fmt.Println("display: appointment is now " + a.Status)
	})
	appt.SetStatus("arrived") // prints: display: appointment is now arrived
}
