module fisherExact;

import std.algorithm: sum;

import core.stdc.stdio: printf;
import core.stdc.math: log, exp;
import core.stdc.stdlib: atoi, malloc, free;

extern(C):

int main(int argc, const char** argv) {
	// checking num of agruments
	if(argc < 2) {
		printf("Specify number of iterations!\n");
		return 0;
	}
	
	// our contingency table
	const long[4] data = [
		1982, 3018,
		2056, 2944
	];
		
	double pvalue = 0.0;
	foreach(i; 0..argv[1].atoi) {
		pvalue = data.fisherExact;
	}
	
	printf("pvalue = %f\n", pvalue);

	return 0;
}

void logFactorial(const long n, double* fs) {
	fs[0] = 0;
	foreach(i; 1..(n+1)) {
		fs[i] = fs[i-1] + log(i);
	}
}

double logHypergeometricProbability(const ref long[4] data, const double* fs) {
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

double fisherExact(const long[4] data) {
	// sum all table values
	const grandTotal = data[0..$].sum;
	
	// allocate factorials
	double* factorials = cast(double*)(malloc(double.sizeof * (grandTotal + 1))); 
	scope(exit) { factorials.free; }
	
	// save factorial values for repeated use in the loop below
	logFactorial(grandTotal, factorials);

	// calculate our rejection threshold
	const pvalThreshold = logHypergeometricProbability(data, factorials);

	double pvalFraction = 0;
	for(long i = 0; i <= grandTotal; i++) {
		if((data[0] + data[1] - i >= 0) && (data[0] + data[2] - i >= 0) && (data[3] - data[0] + i >=0)) {
			const long[4] temp = [
				i,
				data[0] + data[1] - i,
				data[0] + data[2] - i,
				data[3] - data[0] + i
			];

			double lhgp = logHypergeometricProbability(temp, factorials);

			if(lhgp <= pvalThreshold) {
				pvalFraction += exp(lhgp - pvalThreshold);
			}
		}
	}

	return (exp(pvalThreshold) * pvalFraction);
}
















