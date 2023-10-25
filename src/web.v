import vweb

struct App {
	vweb.Context
pub:
	index map[string][]string [vweb_global]
}

pub fn App.new() App {
	return App{
		index: build_index()
	}
}

['/'; get]
fn (mut app App) page_home() vweb.Result {
	key := app.query['q'].to_lower()
	if key == '' {
		app.set_status(400, '')
		return app.text('no query informed.')
	}

	result := app.index[key]
	if result != [] {
		// Evaluate redirection.
		if result.len == 4 {
			last := result[2]
			if last.starts_with('{') && last.ends_with('}') {
				return app.redirect('/?q=${last[1..last.len_utf8() - 1]}')
			}
		}

		return app.text(result.join('\n'))
	} else {
		matches := find_matches(key, app.index)
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
