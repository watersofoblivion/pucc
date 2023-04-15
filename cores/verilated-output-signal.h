#include <cstdint>

#include "cores/cores.h"

#include "verilated-port.h"

#pragma once

namespace cores {
  class VerilatedOutputSignal : public VerilatedOutput, public VerilatedSignal, public OutputSignal {
  public:
    virtual ~VerilatedOutputSignal() = default;
  };
}