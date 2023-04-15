#pragma once

#include "cores/cores.h"
#include "verilated-port.h"

namespace cores {
  class VerilatedInput : public VerilatedPort, Input {
  public:
    virtual ~VerilatedInput() = default;
  };
}