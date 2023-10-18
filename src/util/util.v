module util

pub fn find_matches(key string, db map[string][]string) []string {
	mut mattches := []string{}

	// Find similar terms
	for term in db.keys() {
		// Normalize terms
		norm := normalize_terms(key, term)
		prob := evaluate_match_proability(norm)
		if prob > 0.50 {
			mattches << term
		}
	}

	return mattches
}

struct NormalizedTerm {
	key  string
	term string
}

fn normalize_terms(key string, term string) NormalizedTerm {
	mut new_key := key.clone()
	mut new_term := term.clone()

	key_len := key.len_utf8()
	term_len := term.len_utf8()

	if key_len > term_len {
		// Add white spaces to the term
		diff := key_len - term_len
		new_term = new_term + ' '.repeat(diff)
	} else {
		// Add white spaces to the key
		diff := term_len - key_len
		new_key = new_key + ' '.repeat(diff)
	}

	return NormalizedTerm{
		key: new_key
		term: new_term
	}
}

fn count_mattch(norm NormalizedTerm) u8 {
	mut total_mattch := u8(0)
	for i in 0 .. norm.key.len_utf8() {
		if norm.key[i].str() == norm.term[i].str() {
			total_mattch++
		}
	}
	return total_mattch
}

fn evaluate_match_proability(norm NormalizedTerm) f32 {
	// Now the strings have the same size,
	// let's compare each character to other.
	total_mattch := count_mattch(norm)

	// Find the probability
	return f32(total_mattch) / f32(norm.key.len_utf8())
}
