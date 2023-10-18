module util

import os

pub fn get_input() string {
	mut args := os.args.clone()
	args.delete(0)
	if args.len == 0 {
		eprintln('invalid argument.')
		exit(1)
	}
	return args.join(' ')
}
