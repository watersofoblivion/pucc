#pragma once

#include "cores/cores.h"
#include "verilator-port.h"

namespace cores {
  template <typename WIDTH>
  class VerilatorBus : public VerilatorPort, Bus<WIDTH> {
  public:
    VerilatorBus(WIDTH& wire) : wire{wire} {
    }

    virtual ~VerilatorBus() = default;

  protected:
    WIDTH& wire;
  };

  template <>
  class VerilatorBus<bool> : public VerilatorPort, Bus<bool> {
  public:
    VerilatorBus(uint8_t& wire) : wire(wire) {}
    virtual ~VerilatorBus() = default;

  protected:
    uint8_t& wire;
  };
}