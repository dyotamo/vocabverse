module util

import vweb

const idx = build_index()

struct App {
	vweb.Context
}

pub fn App.new() App {
	return App{}
}

['/']
fn (mut app App) page_home() vweb.Result {
	key := app.query['key'].to_lower()
	if key == '' {
		app.set_status(400, '')
		return app.text('no key informed.')
	}

	result := util.idx[key]
	if result != [] {
		// Evaluate redirection.
		if result.len == 4 {
			last := result[2]
			if last.starts_with('{') && last.ends_with('}') {
				return app.redirect('/?key=${last[1..last.len_utf8() - 1]}')
			}
		}

		return app.text(result.join('\n'))
	} else {
		matches := find_matches(key, util.idx)
		app.set_status(404, '')

		mut msg := 'oops, [${key}] was not found!'
		if matches != [] {
			msg += '

Did you mean:

${matches.join('?\n')}?'
		}
		return app.text(msg)
	}
}
