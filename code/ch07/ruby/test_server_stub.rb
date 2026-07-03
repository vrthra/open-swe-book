# §7.5.2 Deploying Test Servers — a stub HTTP server programmed to return 500,
# asserting the clinic client's fallback behavior.
require "net/http"
require "socket"

stub = TCPServer.new("127.0.0.1", 0)
Thread.new do
  loop do
    client = stub.accept                 # a stub programmed to always fail
    client.gets("\r\n\r\n")              # consume the request head
    client.write "HTTP/1.1 500 Internal Server Error\r\nContent-Length: 0\r\n\r\n"
    client.close
  end
end

def fetch_appointments(base_url)
  resp = Net::HTTP.get_response(URI(base_url + "/appointments"))
  resp.is_a?(Net::HTTPSuccess) ? resp.body : []  # fallback: empty schedule
end

port = stub.addr[1]
raise unless fetch_appointments("http://127.0.0.1:#{port}") == []
stub.close
puts "client fell back to an empty schedule on 500"
