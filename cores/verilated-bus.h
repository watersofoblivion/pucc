#pragma once

#include "cores/cores.h"
#include "verilated-port.h"

namespace cores {
  template <typename WIDTH>
  class VerilatedBus : public VerilatedPort, Bus<WIDTH> {
  public:
    VerilatedBus(WIDTH& wire) : wire(wire) {
    }

    virtual ~VerilatedBus() = default;

  protected:
    WIDTH& wire;
  };
}