#include <cstdint>

#include "cores/cores.h"

#include "verilated-bus.h"

#pragma once

namespace cores {
  template <typename WIDTH>
  class VerilatedInputBus : public VerilatedInput, public VerilatedBus<WIDTH>, public InputBus<WIDTH> {
  public:
    VerilatedInputBus(WIDTH& wire) : VerilatedBus<WIDTH>(wire) {
    }

    virtual ~VerilatedInputBus() = default;

    virtual void Set(const WIDTH value) final {
      this->wire = value;
    };
  };
}