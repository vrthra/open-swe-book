# §7.2.2 Observers and Subscribers — a subject that notifies without knowing
# its observers' concrete types (clinic scheduler: waiting-room display).
class Appointment:
  def __init__(self, status="booked"):
    self.status = status
    self._observers = []

  def subscribe(self, observer):
    self._observers.append(observer)

  def set_status(self, new_status):
    self.status = new_status
    for obs in self._observers:      # any object with update() will do
      obs.update(self)

class WaitingRoomDisplay:
  def update(self, appointment):
    print(f"display: appointment is now {appointment.status}")

appt = Appointment()
appt.subscribe(WaitingRoomDisplay())
appt.set_status("arrived")               # prints: display: appointment is now arrived
