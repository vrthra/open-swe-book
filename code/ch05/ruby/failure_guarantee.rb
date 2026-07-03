# Chapter 5, §5.3.1 — the failure postcondition of "Withdraw Cash from ATM" as a test:
# no money out without a matching debit, even when the authorization link drops (B1).
class LostLinkBank                          # the fake — the link drops at step 8
  attr_reader :debits
  def initialize = @debits = []
  def authorize(amount) = raise(IOError, "link lost")
end

class Atm
  attr_reader :dispensed
  def initialize = @dispensed = 0
  def dispense(amount) = @dispensed += amount
end

def withdraw(atm, bank, amount)             # steps 8–11 of the basic flow
  bank.authorize(amount)
  atm.dispense(amount)
  bank.debits << amount
rescue IOError                              # B1 — cancel, return the card
end

atm, bank = Atm.new, LostLinkBank.new
withdraw(atm, bank, 200)
# the failure postcondition, verbatim
raise "postcondition violated" unless atm.dispensed == 0 && bank.debits.empty?
puts "failure guarantee holds: no cash dispensed, no debit recorded"
