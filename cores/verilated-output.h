#pragma once

#include "cores/cores.h"
#include "verilated-port.h"

namespace cores {
  class VerilatedOutput : public VerilatedPort, public Output {
  public:
    virtual ~VerilatedOutput() = default;
  };
}