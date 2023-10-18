module main

import util

fn main() {
	key := util.get_input()
	db := util.setup_database()

	search := db[key] // Fetch operation...
	if search != [] {
		println('${key}:\n')
		println('${search.join('\n')}')
	} else {
		println('Oops, [${key}] was not found.\n')
		mattches := util.find_matches(key, db)
		if mattches.len > 0 {
			println('Did you mean:')
			for mattch in mattches {
				println('${mattch}?')
			}
		}
	}
}
