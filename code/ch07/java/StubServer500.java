// §7.5.2 Deploying Test Servers — a stub HTTP server programmed to return 500,
// asserting the clinic client's fallback behavior.
// Compact source file (JDK 25+): run with `java -ea StubServer500.java`.
import com.sun.net.httpserver.HttpServer;

byte[] fetchAppointments(String baseUrl) {
  try (var in = URI.create(baseUrl + "/appointments").toURL().openStream()) {
    return in.readAllBytes();
  } catch (IOException e) {
    return new byte[0];                  // fallback: empty schedule, not a crash
  }
}

void main() throws Exception {
  var stub = HttpServer.create(new InetSocketAddress("127.0.0.1", 0), 0);
  stub.createContext("/", exchange -> exchange.sendResponseHeaders(500, -1));
  stub.start();                          // serves requests on a background thread

  var base = "http://127.0.0.1:" + stub.getAddress().getPort();
  assert fetchAppointments(base).length == 0;
  stub.stop(0);
  IO.println("client fell back to an empty schedule on 500");
}
