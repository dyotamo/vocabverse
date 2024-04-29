module main

import util
import vweb

const port = 8080

fn main() {
	vweb.run(util.App.new(util.build_index()), 8080)
}
