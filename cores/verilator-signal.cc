#include <iostream>

#include "cores/cores.h"
#include "verilator-signal.h"

namespace cores {
  VerilatorSignal::VerilatorSignal(uint8_t& wire) : VerilatorBus<bool>(wire) {
  }
}