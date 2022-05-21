/*
Sonny Ji
ECE335
Homework #1
*/

#include <stdio.h>
typedef unsigned char *byte_pointer;

void show_bytes(byte_pointer start, size_t len) {
	int i;
	for(i = 0; i < len; i++)
		printf(" %.2x", start[i]);
	printf("\n");
}

int any_odd_one(unsigned);

int main() {
	//Problem 1
	unsigned int ux = 14281;
	int sx = -14281;
	float fx = 14281.0;
	printf("Unsigned (0...0 0011 0111 1100 1001) [0x 00 00 37 c9]");
	show_bytes((byte_pointer) &ux, sizeof(unsigned int));
	printf("Signed negative (1...1 1100 1000 0011 0111) [0x ff ff c8 37]");
	show_bytes((byte_pointer) &sx, sizeof(int));
	printf("Float (0100 0110 0101 1111 0010 0100 0000 0000) [0x 46 5f 24 00]");
	show_bytes((byte_pointer) &fx, sizeof(float));
	
	//Problem 2
	unsigned int x = 0;
	printf("0 (0) -> %d\n", any_odd_one(x));
	x = 1;
	printf("1 (1) -> %d\n", any_odd_one(x));
	x = 2;
	printf("2 (0) -> %d\n", any_odd_one(x));
	x = 3;
	printf("3 (1) -> %d\n", any_odd_one(x));
	x = 4;
	printf("4 (1) -> %d\n", any_odd_one(x));
	x = 170;
	printf("170 (10101010) (0) -> %d\n", any_odd_one(x));
	x = 85;
	printf("85 (01010101) (1) -> %d\n", any_odd_one(x));
	return 0;
}

//Problem 2
int any_odd_one(unsigned x) {
	if((x & 0x55555555) && 1) {
		return 1;
	}
	else
		return 0;
}