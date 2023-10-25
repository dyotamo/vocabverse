import vweb

const (
	port = 8080
)

fn main() {
	vweb.run(App.new(), port)
}
