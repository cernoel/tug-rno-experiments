                                          ;#include <stdio.h>

                                          ;int R0; // is always 0
                                          ;int R1; // for adding 1
                                          ;int R2; // spacesToTab
                                          ;int R3; // asciiSpace
                                          ;int R4; // asciiTab
                                          ;int R5; // asciiEof
                                          ;int R6; // spaceCounter
                                          ;int R7; // buffer
                                          ;int R8; // spaces
                                          ;int R9; // temp

                                          ;void main(void)
                                          ;{
                                          ;      R0 = 0;
      LDA R1  1                           ;      R1 = 1;
      LDA R2  3                           ;      R2 = 3;
      LDA R3  32                          ;      R3 = 32;
      LDA R4  9                           ;      R4 = 9;
      LDA R5  0x03                        ;      R5 = EOF;
      LDA R6  0                           ;      R6 = 0;
      LDA R7  0                           ;      R7 = 0;
      LDA R8  0                           ;      R8 = 0;
      LDA R9  0                           ;      R9 = 0;

L01   LD  R7  0xFF                        ;L01:  R7 = getchar();
      SUB R9  R5  R7                      ;      R9 = R5 - R7;
      BZ  R9  T01                         ;      if(R9 == 0) goto T01;
E01   SUB R9  R7  R3                      ;E01:  R9 = R7 - R3;
      BZ  R9  T04                         ;      if(R9 == 0) goto T04;
      BZ  R0  E04                         ;      goto E04;
T04   ADD R6  R6  R1                      ;T04:  R6 = R6 + R1;
      SUB R9  R6  R2                      ;      R9 = R6 - R2;
      ADD R9  R9  R1                      ;      R9 = R9 + R1;
      BP  R9  T05                         ;      if(R9 > 0) goto T05;
      BZ  R0  E05                         ;      goto E05;
T05   ST  R4  0xFF                        ;T05:  putchar(R4);
      LDA R6  0                           ;      R6 = 0;
E05   BZ  R0  X01                         ;E05:  goto X01;
E04   BP  R6  T03                         ;E04:  if(R6 > 0) goto T03;
      BZ  R0  E03                         ;      goto E03;
T03   LDA R8  0                           ;T03:  R8 = 0;
L02   SUB R9  R6  R8                      ;L02:  R9 = R6 - R8;
      BP  R9  T02                         ;      if(R9 > 0) goto T02;
      BZ  R0  E02                         ;      goto E02;
T02   ST  R3  0xFF                        ;T02:  putchar(R3);
      ADD R8  R8  R1                      ;      R8 = R8 + R1;
      BZ  R0  L02                         ;      goto L02;
E02   ST  R7  0xFF                        ;E02:  putchar(R7);
      LDA R6  0;                          ;      R6 = 0;
      BZ  R0  X01                         ;      goto X01;
E03   ST  R7  0xFF                        ;E03:  putchar(R7);
X01   BZ  R0  L01                         ;X01:  goto L01;
T01   HLT                                 ;T01:  return 0;
                                          ;}

