fn test_match_two_terms() {
	// setup
	index := {
		'mxisptlc': ['behavior', 'feeling']
		'mxyzp':    ['bitch', 'animal']
		'dyotamo':  ['cafe', 'value']
	}

	// test
	matches := find_matches('mxyzptlk', index)

	// assert
	assert matches.len == 2
}
