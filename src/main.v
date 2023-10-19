module main

import util
import vweb

const port = 8080

fn main() {
	vweb.run(util.App.new(), 8080)
}
