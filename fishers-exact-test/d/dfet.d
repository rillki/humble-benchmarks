module fisherExact;

import std.stdio: writeln;
import std.algorithm: sum, min;
import std.conv: to;

// phobos std.math functions are very accurate but quite slow,
// in my tests this makes a 2-3x speed difference overall
version (phobosMath)
	import std.math : log, exp;
else version (libcMath)
	import core.stdc.math : log, exp;
else static assert(false, "Please set version phobosMath or libcMath");

void main(string[] argv) {
	// checking num of agruments
	if(argv.length < 2) {
		"Specify number of iterations!".writeln;
		return;
	}

	// our contingency table
	const long[4] data = [
		1982, 3018,
		2056, 2944
	];

	double pvalue = 0.0;
	foreach(i; 0..argv[1].to!int) {
		pvalue = data.fisherExact;
	}

	writeln("pvalue = ", pvalue);
}

double[] logFactorial(const long n) {
	auto fs = new double[](n + 1);

	fs[0] = 0;
	foreach(i; 1..(n+1)) {
		fs[i] = fs[i-1] + log(i);
	}

	return fs;
}

pragma(inline, true)
double logHypergeometricProbability(const long[] data, const double[] fs) {
	return
		fs[data[0] + data[1]] +
		fs[data[2] + data[3]] +
		fs[data[0] + data[2]] +
		fs[data[1] + data[3]] -
		fs[data[0]] -
		fs[data[1]] -
		fs[data[2]] -
		fs[data[3]] -
		fs[data[0] + data[1] + data[2] + data[3]];
}

// really need to do more than this pragma to make sure the optimizer doesn't cheat
// and inline fisherExact in to main and then start using up-front knowledge of the
// contingency table or see that they whole "loop n times" edifice doesn't change the
// result, or something more subtle (pulling some calculations outside of the loop),
// all of which will give misleading benchmark results.
pragma(inline, false)
double fisherExact(const long[] data) {
	// sum all table values
	const grandTotal = data.sum;

	// save factorial values for repeated use in the loop below
	const factorials = logFactorial(grandTotal);

	// calculate our rejection threshold
	const pvalThreshold = logHypergeometricProbability(data, factorials);

	double pvalFraction = 0;
	foreach(i; data[3] - data[0] .. data[0] + min(data[1], data[2]) + 1) {
		const long[4] newData = [ // being explicit about not allocating
			i,
			data[0] + data[1] - i,
			data[0] + data[2] - i,
			data[3] - data[0] + i
		];

		double lhgp = logHypergeometricProbability(newData, factorials);

		if(lhgp <= pvalThreshold) {
			pvalFraction += exp(lhgp - pvalThreshold);
		}
	}

	return (exp(pvalThreshold) * pvalFraction);
}
