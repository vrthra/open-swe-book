// §7.2.2 Observers and Subscribers — a subject that notifies without knowing
// its observers' concrete types (clinic scheduler: waiting-room display).
// Compact source file (JDK 25+): run with `java ObserverClinic.java`.
interface Observer { void update(Appointment appointment); }

class Appointment {
  String status = "booked";
  private final List<Observer> observers = new ArrayList<>();

  void subscribe(Observer observer) { observers.add(observer); }

  void setStatus(String newStatus) {
    status = newStatus;
    for (Observer obs : observers) obs.update(this);   // any Observer will do
  }
}

class WaitingRoomDisplay implements Observer {
  public void update(Appointment appointment) {
    IO.println("display: appointment is now " + appointment.status);
  }
}

void main() {
  Appointment appt = new Appointment();
  appt.subscribe(new WaitingRoomDisplay());
  appt.setStatus("arrived");             // prints: display: appointment is now arrived
}
