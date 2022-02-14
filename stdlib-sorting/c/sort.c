#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int cmp(const void* a, const void* b);

int main(void) {
	srand(time(NULL));
	const size_t size = 10000000;
	int *array = calloc(size, sizeof(int));

	// generate random numbers
	for(size_t i = 0; i < size; i++) {
		array[i] = rand() % size;
	}

	// measure execution time
	clock_t start = clock();
	qsort(array, size, sizeof(int), cmp);
	clock_t stop = clock();

	// print the result
	double duration = ((double)(stop - start))/CLOCKS_PER_SEC * 1000;
	printf("done: %.0f msecs\n", duration);

	free(array);
	return 0;
}

int cmp(const void* a, const void* b) {
	if(*(int*)a < *(int*)b) {
		return -1;
	} else if(*(int*)a > *(int*)b) {
		return 1;
	} else {
		return 0;
	}
}
