#include <cstdint>

#include "cores/cores.h"

#include "verilated-port.h"

#pragma once

namespace cores {
  template <typename WIDTH>
  class VerilatedInputPort : public VerilatedPort {
  public:
    virtual ~VerilatedInputPort() = default;

    virtual void Set(const WIDTH) = 0;
  };
}