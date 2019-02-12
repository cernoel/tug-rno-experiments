#include <stdio.h>

int spacesToTab = 3; 			// convert n spaces to one Tab
int asciiSpace = 32; 			// ascii int 32 is space
int asciiTab = 9; 			// ascii int 9 is Horizontal Tab
int asciiEof = EOF; 			// ascii int -1 or 255 in two complement's is EOF
int spaceCounter = 0; 			// with this counter we count the actual spaces
int buffer; 				// here we store our input
int spaces;				// is needed to count outputted spaces

int main(void) 			// no extra in or output, but gives us a compiler warning!
{
  buffer = getchar();			// read first char into buffer
  while(buffer != asciiEof)		// read only till EOF
  {
    if(buffer == asciiSpace)		// if there is a space ...
    {
      spaceCounter++;			// add 1 to our spaceCounter
      if(spaceCounter >= spacesToTab)	// if we reached our spaceCounter Limit (spacesToTab)
      {
        putchar(asciiTab);		// print out Tab
        spaceCounter = 0;		// set spaceCounter to 0
      }
    }
    else				// else if there is no space
    {
      if(spaceCounter > 0)		// if we encountered spaces ... (rebuild them)
      {				// for each counted space we read ...
        for(spaces = 0; spaces < spaceCounter; spaces++)
        {
          putchar(asciiSpace);		// print out a space
        }
        putchar(buffer);		// then print out the buffered char
        spaceCounter = 0;		// reset spaceCounter to 0
      }
      else				// else if there is no space
      {
        putchar(buffer);		// simply print out the buffered input
      }
    }
    buffer = getchar();			// get new char
  }
  return 0;
}

