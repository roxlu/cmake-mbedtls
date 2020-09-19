extern "C" {
#  include <mbedtls/config.h>
#  include "mbedtls/md.h"
#  include "mbedtls/x509.h"
#  include "mbedtls/base64.h"
}

#include <stdio.h>
#include <Monkies.h>

int Monkies::init() {
  printf("Hi, I'm a monkey.\n");
  return 0;
}

int Monkies::shutdown() {
  printf("Bye, was fun doing business.\n");
  return 0;
}
