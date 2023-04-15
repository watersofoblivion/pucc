#pragma once

#include "cores/cores.h"
#include "verilator-port.h"

namespace cores {
  class VerilatorOutput : public VerilatorPort, public Output {
  public:
    virtual ~VerilatorOutput() = default;
  };
}