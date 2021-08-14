#include <iostream>
#include <cmath>
#include <vector>
#include <array>
#include <numeric>
#include <stdlib.h>

std::vector<double> logFactorial(const long n) {
    std::vector<double> fs(n + 1);
	
	fs[0] = 0;
	for(long i = 1; i < n+1; i++) {
		fs[i] = fs[i-1] + log(i);
	}
    
    return fs;
}

double logHypergeometricProbability(const std::array<long, 4>& data, const std::vector<double>& fs) {
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

double fisher_exact(const std::array<long, 4>& data) {
    // sum all table values
	const long grandTotal = data[0] + data[1] + data[2] + data[3];
	
    // save factorial values for repeated use in the loop below
    const std::vector<double> factorials = logFactorial(grandTotal);
    
    // calculate our rejection threshold
	const double pvalThreshold = logHypergeometricProbability(data, factorials);
	
    double pvalFraction = 0;
	for(long i = 0; i <= grandTotal; i++) {
		if((data[0] + data[1] - i >= 0) && (data[0] + data[2] - i >= 0) && (data[3] - data[0] + i >=0)) {
            double lhgp = logHypergeometricProbability({
                i,
                data[0] + data[1] - i,
                data[0] + data[2] - i,
                data[3] - data[0] + i
            }, factorials);

			if(lhgp <= pvalThreshold) {
				pvalFraction += exp(lhgp - pvalThreshold);
			}
		}
	}
    
	return exp(pvalThreshold + log(pvalFraction));
}

int main(int argc, char* argv[]) {
    // checking num of agruments
    if(argc < 2) {
        std::cout << "Specify number of iterations!\n";
        return 0;
    }
    
    // our contingency table
	const std::array<long, 4> data = {
        1982, 3018,
        2056, 2944
    };
    
    double pvalue = 0.0;
	for(size_t i = 0; i < atoi(argv[1]); i++) {
		pvalue = fisher_exact(data);
	}
    
    std::cout << "pvalue = " << pvalue << "\n";
    
	return 0;
}