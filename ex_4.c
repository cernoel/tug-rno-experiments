// mod01: removed comments
// mod02: for loop to while loop
// mod03: while to unconditional while
// mod04: while to goto .. Label Lnn
// mod05: convert if -> goto then, else..
//        Label Tnn for if -> then
//        Label Enn for       else
//        Label Xnn for       exit (where then or else ends)
//        Lnn is loops
//        Tnn is thens
//        Enn is else's
//        Xnn is Exits
// mod06: all c variables to Registers
// mod07: simplify all if(x>y) or if(x==y) to x=0 or x>0
//        x==y ... temp = x - y ... if temp == 0...
//        introducing temp (R9) Register.
#include <stdio.h>

int R0; // is always 0
int R1; // for adding 1
int R2; // spacesToTab
int R3; // asciiSpace
int R4; // asciiTab
int R5; // asciiEof
int R6; // spaceCounter
int R7; // buffer
int R8; // spaces
int R9; // temp

int main(void)
{
R0 = 0;
R1 = 1;
R2 = 3;
R3 = 32;
R4 = 9;
R5 = EOF;
R6 = 0;
R7 = 0;
R8 = 0;
R9 = 0;

L01:  R7 = getchar();
      R9 = R5 - R7;
      if(R9 == 0) goto T01;
      R9 = R7 - R3;
      if(R9 == 0) goto T04;
      goto E04;
T04:  R6 = R6 + R1;
      R9 = R6 - R2;
      R9 = R9 + R1;
      if(R9 > 0) goto T05;
      goto E05;
T05:  putchar(R4);
      R6 = 0;
E05:  goto X01;
E04:  if(R6 > 0) goto T03;
      goto E03;
T03:  R8 = 0;
L02:  R9 = R6 - R8;
      if(R9 > 0) goto T02;
      goto E02;
T02:  putchar(R3);
      R8 = R8 + R1;
      goto L02;
E02:  putchar(R7);
      R6 = 0;
      goto X01;
E03:  putchar(R7);
X01:  goto L01;
T01:  return 0;
}

