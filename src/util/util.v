module util

pub fn find_matches(key string, index map[string][]string) []string {
	mut mattches := []string{}

	// Find similar terms.
	for term in index.keys() {
		// Normalize terms.
		new_key, new_term := normalize_terms(key, term)
		prob := evaluate_match_probability(new_key, new_term)
		if prob > 0.50 {
			mattches << term
		}
	}

	return mattches
}

fn normalize_terms(key string, term string) (string, string) {
	mut new_key := key.clone()
	mut new_term := term.clone()

	key_len := key.len_utf8()
	term_len := term.len_utf8()

	if key_len > term_len {
		// Add white spaces to the term.
		diff := key_len - term_len
		new_term = new_term + ' '.repeat(diff)
	} else {
		// Add white spaces to the key.
		diff := term_len - key_len
		new_key = new_key + ' '.repeat(diff)
	}

	return new_key, new_term
}

fn count_mattch(key string, term string) u8 {
	mut total_mattch := u8(0)
	for i in 0 .. key.len_utf8() {
		if key[i].str() == term[i].str() {
			total_mattch++
		}
	}
	return total_mattch
}

fn evaluate_match_probability(key string, term string) f32 {
	// Now the strings have the same size,
	// let's compare each character to other.
	total_mattch := count_mattch(key, term)

	// Find the probability.
	return f32(total_mattch) / f32(key.len_utf8())
}
