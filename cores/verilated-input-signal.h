#pragma once

#include <cstdint>

#include "cores/cores.h"

#include "verilated-signal.h"
#include "verilated-input.h"

namespace cores {
  class VerilatedInputSignal : public VerilatedInput, public VerilatedSignal, public InputSignal {
  public:
    VerilatedInputSignal(uint8_t& wire);
    virtual ~VerilatedInputSignal() = default;

    void Set(const bool) final;
  };
}