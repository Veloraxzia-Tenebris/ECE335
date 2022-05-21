#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define LENGTH 5000
#define K 10000

void combine3(double * A, double * dest, int length);
void combine5(double * A, double * dest, int length);
void combine7(double * A, double * dest, int length);
int main1();

double tt1, tt2, tt3;

int main() {
	int average_loop = 50;
	double tt1_ = 0.0, tt2_ = 0.0, tt3_ = 0.0;

	// Loop main function 50 times
	for(int i = 0; i < average_loop; i++) {
		main1();
		tt1_ += tt1;
		tt2_ += tt2;
		tt3_ += tt3;
	}

	// Print averages
	printf("\n");
	printf("combine3 takes %.2f ms after a 50 run average\n", (tt1_ / average_loop));
	printf("combine5 takes %.2f ms after a 50 run average\n", (tt2_ / average_loop));
	printf("combine7 takes %.2f ms after a 50 run average\n", (tt3_ / average_loop));

	return 0;
}

void combine3(double* A, double* dest, int length) {
	for (int i = 0; i < length; i++) {
		*dest = *dest * A[i];
	}
}

void combine5(double* A, double* dest, int length) {
	int i;
	int limit = length - 1;
	double acc = 1;
	for (i = 0; i < limit; i += 2) {
		acc = (acc * A[i]) * A[i + 1]; 
	}
	for (; i < length; i++) {
		acc = acc * A[i];
	} 
	*dest = acc;
}

void combine7(double* A, double* dest, int length) {
	long i;
	long limit = length - 1;
	double acc = 1;
	for (i = 0; i < limit; i += 2) {
		acc = acc * (A[i] * A[i + 1]);
	}
	for (; i < length; i++) {
		acc = acc * A[i];
	}
	*dest = acc;
}

int main1() {
	int length = LENGTH;

	// Make array A with random data
	double A[length];
	for (int i = 0; i < length; i++) {
		A[i] = 0.90 + (double)(rand() % K) / 50000.0;
	}

	// Destination variable
	double a = 1;

	// Amount to loop
	int loop_number = 10000;

	clock_t t0 = 0;
	clock_t tf = 0;
	tt1 = 0.0;
	tt2 = 0.0;
	tt3 = 0.0;

	// combine3
	// Loop a function 10,000 times and record the execution time
	for(int i = 0; i < loop_number; i++) {
		t0 = clock();
		combine3(A, &a, length);
		t0 = clock() - t0;
		tf += t0;
	}
	// Normalize and print time in ms
	tt1 = (((double) tf) / CLOCKS_PER_SEC) * 1000;
	printf("combine3 x 10,000 takes %.2f ms\n", tt1);

	// combine5
	t0 = 0;
	tf = 0;
	a = 1;
	for(int i = 0; i < loop_number; i++) {
		t0 = clock();
		combine5(A, &a, length);
		t0 = clock() - t0;
		tf += t0;
	}
	tt2 = (((double) tf) / CLOCKS_PER_SEC) * 1000;
	printf("combine5 x 10,000 takes %.2f ms\n", tt2);

	// combine7
	t0 = 0;
	tf = 0;
	a = 1;
	for(int i = 0; i < loop_number; i++) {
		t0 = clock();
		combine7(A, &a, length);
		t0 = clock() - t0;
		tf += t0;
	}
	tt3 = (((double) tf) / CLOCKS_PER_SEC) * 1000;
	printf("combine7 x 10,000 takes %.2f ms\n", tt3);

	return 0;
}