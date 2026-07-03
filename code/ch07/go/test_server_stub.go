// §7.5.2 Deploying Test Servers — a stub HTTP server programmed to return 500,
// asserting the clinic client's fallback behavior.
package main

import (
	"fmt"
	"io"
	"net/http"
	"net/http/httptest"
)

func alwaysFail(w http.ResponseWriter, _ *http.Request) { http.Error(w, "boom", 500) }
func fetchAppointments(baseURL string) []byte {
	resp, err := http.Get(baseURL + "/appointments")
	if err != nil || resp.StatusCode >= 400 {
		return nil // fallback: empty schedule, not a crash
	}
	body, _ := io.ReadAll(resp.Body)
	return body
}

func main() {
	stub := httptest.NewServer(http.HandlerFunc(alwaysFail))
	defer stub.Close()
	if len(fetchAppointments(stub.URL)) != 0 {
		panic("client should fall back to an empty schedule on 500")
	}
	fmt.Println("client fell back to an empty schedule on 500")
}
