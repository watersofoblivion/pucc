#include <cstdint>

#include "cores/cores.h"

#include "verilated-signal.h"
#include "verilated-input-signal.h"

namespace cores {
  VerilatedInputSignal::VerilatedInputSignal(uint8_t& wire) : VerilatedSignal(wire) {
  }

  void VerilatedInputSignal::Set(const bool value) {
    wire = value;
  }
}