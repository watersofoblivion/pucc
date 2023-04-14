#pragma once

#include "cores/cores.h"

#include "verilated-input-port.h"

namespace cores {
  class VerilatedClock : public VerilatedInputPort<bool> {
    void Toggle();
  };
}