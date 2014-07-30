#include <stdio.h>
#include <crypt.h>

int main(int argc, char *argv[]) {

  if (argc < 2) {
    printf("usage: ./mkpasswd password\n");
    exit(-1);
  }
      
  printf("%s\n", crypt(argv[1], "$1$tmpsalt$")); 

}
