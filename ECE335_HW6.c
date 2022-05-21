#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define CACHE_SIZE 128
#define BLOCK_SIZE 16
#define LINE_SIZE 2
#define ARRAY_SIZE 8
#define DST_OFFSET 256

typedef int array [ARRAY_SIZE][ARRAY_SIZE];

struct cache_set {
	int valid;
	int tag;
	int time_of_use;
};

char cache_simulator(int address, struct cache_set *cache, int set_index, int block_offset, int line_size) {
	//printf("%x\n", address);
	char out = 'M';
	int time_counter = 0;
	int counter = 0;
	int a = address;
	unsigned mask = ~0;
	mask <<= set_index;
	mask = ~mask;
	a >>= block_offset;
	int s = a & mask;
	int t = a >> set_index;
	for(int i = 0; i < set_index; i++) {
		for(int j = 0; j < line_size; j++) {
			cache[((i * set_index) + j) * sizeof(struct cache_set)].time_of_use++;
		}
	}
	for(int j = 0; j < line_size; j++) {
		if(cache[((s * set_index) + j) * sizeof(struct cache_set)].valid == 1) {
			if(cache[((s * set_index) + j) * sizeof(struct cache_set)].tag == t) {
				out = 'H';
				//printf("Set Index: 0x%x\nValid: 0x%x\nTag: 0x%x\n", s, cache[((s * set_index) + j) * sizeof(struct cache_set)].valid, cache[((s * set_index) + j) * sizeof(struct cache_set)].tag);
				return out;
				break;
			}
		}
	}
	for(int j = 0; j < line_size; j++) {
		if(cache[((s * set_index) + j) * sizeof(struct cache_set)].time_of_use > time_counter) {
			time_counter = cache[((s * set_index) + j) * sizeof(struct cache_set)].time_of_use;
			counter = j;
		}
	}
	cache[((s * set_index) + counter) * sizeof(struct cache_set)].tag = t;
	cache[((s * set_index) + counter) * sizeof(struct cache_set)].valid = 1;
	cache[((s * set_index) + counter) * sizeof(struct cache_set)].time_of_use = 0;
	//printf("Set Index: 0x%x\nValid: 0x%x\nTag: 0x%x\n", s, cache[((s * set_index) + counter) * sizeof(struct cache_set)].valid, cache[((s * set_index) + counter) * sizeof(struct cache_set)].tag);
	return out;
}

void transpose1(array dst, array src, struct cache_set *cache, int set_index, int block_offset, int line_size) {
	int i, j;
	for(i = 0; i < ARRAY_SIZE; i++) {
		for(j = 0; j < ARRAY_SIZE; j++) {
			dst[j][i] = src[i][j];
			printf("src[%d][%d] %c\n", i, j, cache_simulator((((i * ARRAY_SIZE) + j) * 4), cache, set_index, block_offset, line_size));
			printf("dst[%d][%d] %c\n", j, i, cache_simulator(((((j * ARRAY_SIZE) + i) * 4) + DST_OFFSET), cache, set_index, block_offset, line_size));
		}
	}
}

int main() {
	// Constants
	int line_size = LINE_SIZE;
	int address_bits = 4 * 8;

	// Finding S and s
	int set_size = (CACHE_SIZE / (BLOCK_SIZE * (1 << (line_size - 1))));
	int set_index = 0;
	while(set_size > 0) {
		set_size >>= 1;
		set_index++;
	}
	/*
	while(set_size >>= 1) {
		set_index++;
	}
	*/
	// Finding B and b
	int block_offset = 0;
	int block_size = BLOCK_SIZE;
	while(block_size >>= 1) {
		block_offset++;
	}
	// Finding t
	int tag = address_bits - (block_offset + set_index);
	// Setting up simulation cache array
	// cache[Sets][Lines]
	struct cache_set cache[set_index][line_size];
	for(int i = 0; i < set_index; i++) {
		for(int j = 0; j < line_size; j++) {
			cache[i][j].tag = 0;
			cache[i][j].time_of_use = 0;
			cache[i][j].valid = 0;
		}
	}
	// Printing cache information
	printf("Tag: %d\nSet Index: %d\nBlock Offset: %d\nAssociativity: %d\n\n", tag, set_index, block_offset, line_size);
	// Make test arrays
	int data[ARRAY_SIZE][ARRAY_SIZE], dump[ARRAY_SIZE][ARRAY_SIZE];
	srand(clock());
	for(int i = 0; i < ARRAY_SIZE; i++) {
		for(int j = 0; j < ARRAY_SIZE; j++) {
			data[i][j] = rand();
		}
	}

	// Testing cache simulator
	transpose1(data, dump, cache, set_index, block_offset, line_size);

	return 0;
}