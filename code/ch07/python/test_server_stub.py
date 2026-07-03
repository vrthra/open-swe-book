# §7.5.2 Deploying Test Servers — a stub HTTP server programmed to return 500,
# asserting the clinic client's fallback behavior.
import http.server, threading, urllib.error, urllib.request

class AlwaysFail(http.server.BaseHTTPRequestHandler):
  def do_GET(self):
    self.send_error(500)
  def log_message(self, *_):           # keep test output clean
    pass

def fetch_appointments(base_url):
  try:
    with urllib.request.urlopen(base_url + "/appointments") as resp:
      return resp.read()
  except urllib.error.HTTPError:
    return []                        # fallback: empty schedule, not a crash

stub = http.server.HTTPServer(("127.0.0.1", 0), AlwaysFail)
threading.Thread(target=stub.serve_forever, daemon=True).start()

assert fetch_appointments(f"http://127.0.0.1:{stub.server_port}") == []
stub.shutdown()
print("client fell back to an empty schedule on 500")
