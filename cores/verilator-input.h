#pragma once

#include "cores/cores.h"
#include "verilator-port.h"

namespace cores {
  class VerilatorInput : public VerilatorPort, Input {
  public:
    virtual ~VerilatorInput() = default;
  };
}