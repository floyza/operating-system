#include "mytoa.h"

void uintToCStr(unsigned int val, char *c) {
  static const char digitPairs[201] = {"00010203040506070809"
                                       "10111213141516171819"
                                       "20212223242526272829"
                                       "30313233343536373839"
                                       "40414243444546474849"
                                       "50515253545556575859"
                                       "60616263646566676869"
                                       "70717273747576777879"
                                       "80818283848586878889"
                                       "90919293949596979899"};

  int size;

  if (val >= 10000) {
    if (val >= 10000000) {
      if (val >= 1000000000)
        size = 10;
      else if (val >= 100000000)
        size = 9;
      else
        size = 8;
    } else {
      if (val >= 1000000)
        size = 7;
      else if (val >= 100000)
        size = 6;
      else
        size = 5;
    }
  } else {
    if (val >= 100) {
      if (val >= 1000)
        size = 4;
      else
        size = 3;
    } else {
      if (val >= 10)
        size = 2;
      else
        size = 1;
    }
  }

  c += size - 1;
  c[1] = 0;

  while (val >= 100) {
    int pos = (val % 100) * 2;
    val /= 100;
    c[-1] = digitPairs[pos];
    c[0] = digitPairs[pos + 1];
    c -= 2;
  }

  if (val < 10)
    c[0] = '0' + val;
  else {
    c[-1] = digitPairs[val * 2];
    c[0] = digitPairs[val * 2 + 1];
  }
}

void intToCStr(int n, char *c) {
  int sign = -(n < 0);
  unsigned int val = (n ^ sign) - sign;

  if (sign)
    *c++ = '-';

  uintToCStr(val, c);
}
