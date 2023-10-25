import vweb
import v.vmod

struct App {
	vweb.Context
pub:
	index map[string][]string [vweb_global]
	vm    vmod.Manifest       [vweb_global]
}

pub fn App.new() App {
	return App{
		index: build_index()
		vm: vmod.decode(@VMOD_FILE) or { panic(err) }
	}
}

['/'; get]
fn (mut app App) page_home() vweb.Result {
	mut msg := '${app.vm.name} ${app.vm.version} by ${app.vm.author}\n'
	msg += '-'.repeat(msg.len_utf8() - 1) + '\n\n'

	key := app.query['q'].to_lower()
	if key == '' {
		app.set_status(400, '')
		msg += 'no query informed.'
		return app.text(msg)
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

		msg += result.join('\n')
		return app.text(msg)
	} else {
		matches := find_matches(key, app.index)
		app.set_status(404, '')

		msg += 'oops, [${key}] was not found!'
		if matches != [] {
			msg += '

Did you mean:

${matches.join('?\n')}?'
		}
		return app.text(msg)
	}
}
