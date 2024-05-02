module util

pub fn build_index() map[string][]string {
	mut index := map[string][]string{}

	dict := $embed_file('assets/dictionary', .zlib).to_string()
	lines := dict.split('\n')
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
