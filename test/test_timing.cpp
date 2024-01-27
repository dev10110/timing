#include <iostream>
#include <unistd.h>

#include "timing.h"

void f(int ms = 1000) {
  std::cout << "starting f, waiting for " << ms << "ms" << std::endl;
  usleep(1000 * ms);
  std::cout << "done f" << std::endl;
}

int main(int argc, char **argv) {

  // test the functions
  f();

  for (std::size_t i = 0; i < 10; i++) {

    timing::Timer total_timer("total");
    f(200);
  }

  timing::Timing::Print(std::cout);
}
