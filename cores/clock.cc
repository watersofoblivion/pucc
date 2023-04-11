#include "clock.h"

namespace cores {
  void Clock::Toggle() {
    Set(true);
    Set(false);
  }
}