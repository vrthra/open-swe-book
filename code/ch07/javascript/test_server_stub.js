// §7.5.2 Deploying Test Servers — a stub HTTP server programmed to return 500,
// asserting the clinic client's fallback behavior.
const assert = require("node:assert");
const http = require("node:http");

async function fetchAppointments(baseUrl) {
  const resp = await fetch(baseUrl + "/appointments");
  if (!resp.ok) return [];               // fallback: empty schedule, not a crash
  return Buffer.from(await resp.arrayBuffer());
}

const stub = http.createServer((req, res) => res.writeHead(500).end());
stub.listen(0, "127.0.0.1", async () => {
  const base = `http://127.0.0.1:${stub.address().port}`;
  assert.deepStrictEqual(await fetchAppointments(base), []);
  stub.close();
  console.log("client fell back to an empty schedule on 500");
});
