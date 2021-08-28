module fisherExact;

import std.stdio: writeln;
import std.algorithm: sum;
import std.math: log, exp;
import std.conv: to;
import std.array : uninitializedArray;

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

	real pvalue = 0.0;
	foreach(i; 0..argv[1].to!int) {
		pvalue = data.fisherExact;
	}

	writeln("pvalue = ", pvalue);
}

double[] logFactorial(const long n) {
	auto fs = uninitializedArray!(real[])(n + 1);

	fs[0] = 0;
	foreach(i; 1..(n+1)) {
		fs[i] = fs[i-1] + log(i);
	}

	return fs;
}

pragma(inline, true)
real logHypergeometricProbability(const long[] data, const real[] fs) {
	return (
		fs[data[0] + data[1]] +
		fs[data[2] + data[3]] +
		fs[data[0] + data[2]] +
		fs[data[1] + data[3]] -
		fs[data[0]] -
		fs[data[1]] -
		fs[data[2]] -
		fs[data[3]] -
		fs[data[0] + data[1] + data[2] + data[3]]
	);
}

pragma(inline, false)
real fisherExact(const long[] data) {
	// sum all table values
	const grandTotal = data.sum;

	// save factorial values for repeated use in the loop below
	const factorials = logFactorial(grandTotal);

	// calculate our rejection threshold
	const pvalThreshold = logHypergeometricProbability(data, factorials);

	real pvalFraction = 0;
	for(long i = 0; i <= grandTotal; i++) {
		if((data[0] + data[1] - i >= 0) && (data[0] + data[2] - i >= 0) && (data[3] - data[0] + i >=0)) {
			const long[4] newData = [
				i,
				data[0] + data[1] - i,
				data[0] + data[2] - i,
				data[3] - data[0] + i
			];

			real lhgp = logHypergeometricProbability(newData, factorials);

			if(lhgp <= pvalThreshold) {
				pvalFraction += exp(lhgp - pvalThreshold);
			}
		}
	}

	return (exp(pvalThreshold) * pvalFraction);
}
















