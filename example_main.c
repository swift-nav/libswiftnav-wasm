#include <stdio.h>
#include <swiftnav/bits.h>

unsigned lsn_parity(unsigned arg)
{
  return parity(arg);
}

int main(int argc, char* argv[])
{
  int u = 11;
  printf("lsn_parity(%u): %u\n", u, lsn_parity(u));

  return 0;
}
