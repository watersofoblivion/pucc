#pragma once

#include "cores/cores.h"

#include "verilator-bus.h"

namespace cores {
  class VerilatorSignal : public VerilatorBus<bool>, public Signal {
  public:
    VerilatorSignal(uint8_t& wire);
    virtual ~VerilatorSignal() = default;
  };
}