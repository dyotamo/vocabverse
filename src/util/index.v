module util

import os
import log

pub fn build_index() map[string][]string {
	log.info('Mounting databse index...')
	mut index := map[string][]string{}
	lines := os.read_lines('assets/dictionary') or { panic(err) }
	mut term := ''
	for line in lines {
		if (!line.starts_with('\t')) && line != '' {
			// This is a term
			term = line.to_lower()
			index[term] = []string{len: 0, cap: 10}
			index[term] << line
		} else {
			// This is a meaning partial...
			index[term] << line.trim_indent()
		}
	}
	return index
}
