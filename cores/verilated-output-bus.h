#include <cstdint>

#include "cores/cores.h"

#include "verilated-port.h"

#pragma once

namespace cores {
  template <typename WIDTH>
  class VerilatedOutputBus : public VerilatedOutput, public VerilatedBus<WIDTH>, public OutputBus<WIDTH> {
  public:
    virtual ~VerilatedOutputBus() = default;

    virtual WIDTH Get() = 0;
  };
}