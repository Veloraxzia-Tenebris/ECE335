/*
Sonny Ji
ECE335
Homework #2
*/

//Problem 1

//%rdi is x
//%esi is n

//%ecx becomes %esi
	//%ecx becomes value of n
//%edx becomes 1
	//mask becomes 1
//%eax becomes 0
	//result becomes 0
//Go to L2

//L2
//Find if %rdx is 0
	//Find if mask is 0
//Go to L3 if %rdx is not 0
	////Go to L3 if mask is not 0
//Repeat L2
//Go to return address

//L3
//%r8 becomes %rdi
	//%r8 becomes value of x
//%r8 becomes %rdx AND %r8
	//%r8 becomes mask AND x
//%rax becomes %r8 OR %rax
	//result becomes (mask AND x) OR result
//Shift %rdx left by %cl
	//Shift mask left using least significant byte of n

//(f)
long loop(long x, long n)
{
	long result = 0;
	long mask;
	for (mask = 1; mask != 0; mask = mask << (n & 0xFF)) {
		result |= mask & x;
	}
	return result;
}
//For generating a .s file
int main() {
	long a = 8;
	long b = 2;
	loop(a, b);
}