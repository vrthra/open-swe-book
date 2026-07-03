// Chapter 5, §5.3.1 — the failure postcondition of "Withdraw Cash from ATM" as a test:
// no money out without a matching debit, even when the authorization link drops (B1).
const assert = require("node:assert");

class LostLinkBank {                        // the fake — the link drops at step 8
  debits = [];
  authorize(amount) { throw new Error("link lost"); }
}

class Atm {
  dispensed = 0;
  dispense(amount) { this.dispensed += amount; }
}

function withdraw(atm, bank, amount) {      // steps 8–11 of the basic flow
  try { bank.authorize(amount); }
  catch { return; }                         // B1 — cancel, return the card
  atm.dispense(amount);
  bank.debits.push(amount);
}

const atm = new Atm(), bank = new LostLinkBank();
withdraw(atm, bank, 200);
// the failure postcondition, verbatim
assert(atm.dispensed === 0 && bank.debits.length === 0);
console.log("failure guarantee holds: no cash dispensed, no debit recorded");
