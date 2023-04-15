#pragma once

#include <cstdint>

#include "cores/cores.h"

#include "verilated-output.h"
#include "verilated-signal.h"

namespace cores {
  class VerilatedOutputSignal : public VerilatedOutput, public VerilatedSignal, public OutputSignal {
  public:
    VerilatedOutputSignal(uint8_t& wire);
    virtual ~VerilatedOutputSignal() = default;

    void Expect(const bool) final;
    void Assert(const bool) final;
  };
}