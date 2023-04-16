#include <cstdint>

#include "verilator-signal.h"
#include "verilator-bus.h"

namespace cores {
  VerilatorSignal::VerilatorSignal(uint8_t& wire) : VerilatorBus<bool>(wire) {
  }
}