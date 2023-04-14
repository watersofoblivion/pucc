#include <cstdint>

#include "cores/cores.h"

#include "verilated-bus.h"

#pragma once

namespace cores {
  template <typename WIDTH>
  class VerilatedInputSignal : public VerilatedSignal {
  public:
    virtual ~VerilatedInputSignal() = default;
  };
}