use std::env;

use fishers_exact::fishers_exact;

fn main() {
	// checking num of arguments
	let args: Vec<_> = env::args().collect();
	if args.len() < 2 {
		println!("Specify number of iterations!");
		return;
	}

	// our contingency table
	let data = [
		1982, 3018, 
		2056, 2944
	];

	let mut pvalue: f64 = 0.0;
	for _ in 0..args[1].parse::<i32>().unwrap() {
		pvalue = fishers_exact(&data).unwrap().two_tail_pvalue;
	}
	
	println!("pvalue = {}", pvalue);
}
