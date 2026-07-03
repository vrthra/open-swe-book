# §7.2.2 Observers and Subscribers — a subject that notifies without knowing
# its observers' concrete types (clinic scheduler: waiting-room display).
class Appointment
  attr_reader :status

  def initialize(status = "booked")
    @status = status
    @observers = []
  end

  def subscribe(&block)
    @observers << block
  end

  def set_status(new_status)
    @status = new_status
    @observers.each { |notify| notify.call(self) }  # any block will do
  end
end

appt = Appointment.new
appt.subscribe { |a| puts "display: appointment is now #{a.status}" }
appt.set_status("arrived")               # prints: display: appointment is now arrived
