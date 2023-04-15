#pragma once

#include <cstdint>

#include "cores/cores.h"

#include "verilator-signal.h"
#include "verilator-input.h"

namespace cores {
  class VerilatorInputSignal : public VerilatorInput, public VerilatorSignal, public InputSignal {
  public:
    VerilatorInputSignal(uint8_t& wire);
    virtual ~VerilatorInputSignal() = default;

    void Set(const bool) final;
  };
}