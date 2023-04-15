#pragma once

#include <cstdint>

#include "cores/cores.h"

#include "verilator-output.h"
#include "verilator-signal.h"

namespace cores {
  class VerilatorOutputSignal : public VerilatorOutput, public VerilatorSignal, public OutputSignal {
  public:
    VerilatorOutputSignal(uint8_t& wire);
    virtual ~VerilatorOutputSignal() = default;

    void Expect(const bool) final;
    void Assert(const bool) final;
  };
}