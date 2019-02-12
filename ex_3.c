// mod01: removed comments
// mod02: for loop to while loop
// mod03: while to unconditional while
// mod04: while to goto .. Label Lnn
// mod05: convert if -> goto then, else..
//        Label Tnn for if -> then
//        Label Enn for       else
//        Label Xnn for       exit (where then or else ends)

// Lnn is loops
// Tnn is thens
// Enn is else's
// Xnn is Exits
#include <stdio.h>

int spacesToTab = 3;
int asciiSpace = 32;
int asciiTab = 9;
int asciiEof = EOF;
int spaceCounter = 0;
int buffer;
int spaces;

int main(void)
{
L01:  buffer = getchar();
      if(buffer == asciiEof) goto T01;
      goto E01;
E01:  if(buffer == asciiSpace) goto T04;
      goto E04;
T04:  spaceCounter++;
      if(spaceCounter >= spacesToTab) goto T05;
      goto E05;
T05:  putchar(asciiTab);
      spaceCounter = 0;
E05:  goto X02;
E04:  if(spaceCounter > 0) goto T03;
      goto E03;
T03:  spaces = 0;
L02:  if(spaces < spaceCounter) goto T02;
      goto E02;
T02:  putchar(asciiSpace);
      spaces++;
      goto L02;
E02:  putchar(buffer);
      spaceCounter = 0;
      goto X01;
E03:  putchar(buffer);
X01:
X02:  goto L01;
T01:  return 0;
}

