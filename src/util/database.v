module util

import os

pub fn setup_database() map[string][]string {
	mut db := map[string][]string{}
	lines := os.read_lines('assets/dictionary') or { panic(err) }
	mut term := ''
	for line in lines {
		if (!line.starts_with('\t')) && line != '' {
			// This is a term
			term = line
			db[term] = []string{len: 0, cap: 10}
		} else {
			// This is a meaning partial...
			db[term] << line.trim_indent()
		}
	}
	return db
}
