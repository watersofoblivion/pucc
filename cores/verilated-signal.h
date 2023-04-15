#pragma once

#include "cores/cores.h"
#include "verilated-bus.h"

namespace cores {
  class VerilatedSignal : public VerilatedBus<bool>, public Signal {
  public:
    VerilatedSignal(uint8_t& wire);
    virtual ~VerilatedSignal() = default;
  };
}