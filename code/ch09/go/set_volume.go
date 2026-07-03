// §9.4.2 — the buggy boundary guard: `>=` where the spec demands `>`.
package discount

import "errors"

var current int

func apply(level int) { current = level }

func SetVolume(level int) error {
	if level < 1 || level >= 100 { // BUG: >= should be >
		return errors.New("level must be 1..100")
	}
	apply(level)
	return nil
}
