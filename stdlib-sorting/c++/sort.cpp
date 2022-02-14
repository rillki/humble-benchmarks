#include <iostream>
#include <vector>
#include <chrono>
#include <algorithm>
#include <ctime>
#include <cstdlib>

int main() {
	srand(time(NULL));
	constexpr size_t size = 10000000;
	std::vector<int> array(size);

	// generate random numbers
	for(auto &i: array) {
		i = std::rand() % size;
	}

	// measure execution time
	auto start = std::chrono::high_resolution_clock::now();
	std::sort(array.begin(), array.end());
	auto stop = std::chrono::high_resolution_clock::now();

	// print the result
	auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start);
	std::cout << "done: " << duration.count() << " msecs\n";
	return 0;
}
