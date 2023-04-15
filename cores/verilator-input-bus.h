#pragma once

#include <cstdint>

#include <verilated.h>

#include "cores/cores.h"

#include "verilator-input.h"
#include "verilator-bus.h"

namespace cores {
  template <typename WIDTH>
  class VerilatorInputBus : public VerilatorInput, public VerilatorBus<WIDTH>, public InputBus<WIDTH> {
  public:
    VerilatorInputBus(WIDTH& wire) : VerilatorBus<WIDTH>(wire) {}
    virtual ~VerilatorInputBus() = default;

    virtual void Set(const WIDTH value) final {
      this->wire = value;
    };
  };

  template <>
  class VerilatorInputBus<bool> : public VerilatorInput, public VerilatorBus<bool>, public InputBus<bool> {
  public:
    VerilatorInputBus(uint8_t& wire) : VerilatorBus<bool>(wire) {}
    virtual ~VerilatorInputBus() = default;

    virtual void Set(const bool value) final {
      this->wire = value;
    }
  };

  template<std::size_t SIZE>
  class VerilatorInputBus<VlWide<SIZE>> : public VerilatorInput, public VerilatorBus<VlWide<SIZE>>, public InputBus<VlWide<SIZE>> {
  public:
    VerilatorInputBus(VlWide<SIZE>& wire) : VerilatorBus<VlWide<SIZE>>(wire) {}
    virtual ~VerilatorInputBus() = default;

    virtual void Set(const VlWide<SIZE> value) final {
      this->wire = value;
    }
  };
}