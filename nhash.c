#include <stdio.h>

int main()
{
	char nick[] = "jawn";
	int hash = 0;

	hash = (((nick)[0]&31)<<5 | ((nick)[1]&31));
	printf ("%d\n", hash);

	return 1;

}
