#include <cstdint>

#include "cores/cores.h"

#include "verilated-port.h"

#pragma once

namespace cores {
  template <typename WIDTH>
  class VerilatedOutputPort : public VerilatedPort {
  public:
    virtual ~VerilatedOutputPort() = default;

    virtual WIDTH Get() = 0;
  };
}