# Chapter 5, §5.3.1 — the failure postcondition of "Withdraw Cash from ATM" as a test:
# no money out without a matching debit, even when the authorization link drops (B1).
class LostLinkBank:                         # the fake — the link drops at step 8
  debits = []
  def authorize(self, amount): raise ConnectionError("link lost")

class Atm:
  dispensed = 0
  def dispense(self, amount): self.dispensed += amount

def withdraw(atm, bank, amount):            # steps 8–11 of the basic flow
  try: bank.authorize(amount)
  except ConnectionError: return          # B1 — cancel, return the card
  atm.dispense(amount)
  bank.debits.append(amount)

atm, bank = Atm(), LostLinkBank()
withdraw(atm, bank, 200)
assert atm.dispensed == 0 and bank.debits == []  # the failure postcondition, verbatim
print("failure guarantee holds: no cash dispensed, no debit recorded")
