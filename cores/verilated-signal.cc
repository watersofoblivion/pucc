#include "cores/cores.h"
#include "verilated-signal.h"

namespace cores {
  VerilatedSignal::VerilatedSignal(uint8_t& wire) : VerilatedBus<bool>((bool&)wire) {
  }
}