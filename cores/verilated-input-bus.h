#include <cstdint>

#include "cores/cores.h"

#include "verilated-bus.h"

#pragma once

namespace cores {
  template <typename WIDTH>
  class VerilatedInputBus : public VerilatedInput, public VerilatedBus<WIDTH>, public InputBus<WIDTH> {
  public:
    virtual ~VerilatedInputBus() = default;

    virtual void Set(const WIDTH) = 0;
  };
}