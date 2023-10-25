import log

pub fn build_index() map[string][]string {
	log.info('Mounting dictionary index...')

	mut index := map[string][]string{}
	mut term := ''

	dict := $embed_file('assets/dictionary').to_string()
	for line in dict.split('\n') {
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

	log.info('Index mounted...')
	return index
}
