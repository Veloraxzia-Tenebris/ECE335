#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void copyij(int [500][500], int [500][500]);
void copyji(int [500][500], int [500][500]);

void main() {
	clock_t t0, tf = 0;
	double tt = 0.0;
	int data[500][500], dump[500][500];
	srand(clock());
	for(int i = 0; i < 500; i++) {
		for(int j = 0; j < 500; j++) {
			data[i][j] = rand();
		}
	}
	
	// Looping ij 10000 times
	for(int i = 0; i < 10000; i++) {
		t0 = clock();
		copyij(data, dump);
		t0 = clock() - t0;
		tf += t0;
	}
	tt = (((double) tf) / CLOCKS_PER_SEC) * 1000;
	printf("10000 x ij takes %.2f ms\n", tt);
	
	// Looping ji 10000 times
	for(int i = 0; i < 10000; i++) {
		t0 = clock();
		copyji(data, dump);
		t0 = clock() - t0;
		tf += t0;
	}
	tt = (((double) tf) / CLOCKS_PER_SEC) * 1000;
	printf("10000 x ji takes %.2f ms\n", tt);
	return;
}

void copyij(int src[500][500], int dst[500][500]) {
	for(int i = 0; i < 500; i++) {
		for(int j = 0; j < 500; j++) {
			dst[i][j] = src[i][j];
		}
	}
}

void copyji(int src[500][500], int dst[500][500]) {
	for(int j = 0; j < 500; j++) {
		for(int i = 0; i < 500; i++) {
			dst[i][j] = src[i][j];
		}
	}
}