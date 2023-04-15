#include <cstdint>

#include "cores/cores.h"

#include "verilator-signal.h"
#include "verilator-input-signal.h"

namespace cores {
  VerilatorInputSignal::VerilatorInputSignal(uint8_t& wire) : VerilatorSignal(wire) {
  }

  void VerilatorInputSignal::Set(const bool value) {
    wire = value;
  }
}