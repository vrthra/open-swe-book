// §7.2.2 Observers and Subscribers — a subject that notifies without knowing
// its observers' concrete types (clinic scheduler: waiting-room display).
class Appointment {
  constructor(status = "booked") {
    this.status = status;
    this.observers = [];
  }

  subscribe(callback) {
    this.observers.push(callback);
  }

  setStatus(newStatus) {
    this.status = newStatus;
    for (const notify of this.observers) notify(this);  // any callback will do
  }
}

const waitingRoomDisplay = (appointment) =>
  console.log(`display: appointment is now ${appointment.status}`);

const appt = new Appointment();
appt.subscribe(waitingRoomDisplay);
appt.setStatus("arrived");               // prints: display: appointment is now arrived

const assert = require("node:assert");
assert.strictEqual(appt.status, "arrived");
