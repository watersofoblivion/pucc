#pragma once

#include <cstdint>

#include "verilated.h"

#include "cores/cores.h"

#include "verilator-output.h"
#include "verilator-bus.h"

namespace cores {
  template <typename WIDTH>
  class VerilatorOutputBus : public VerilatorOutput, public VerilatorBus<WIDTH>, public OutputBus<WIDTH> {
  public:
    VerilatorOutputBus(WIDTH& wire) : VerilatorBus<WIDTH>(wire) {}
    virtual ~VerilatorOutputBus() = default;

    virtual void Expect(const WIDTH expected) {
      EXPECT_EQ(this->wire, expected);
    }

    virtual void Assert(const WIDTH expected) {
      ASSERT_EQ(this->wire, expected);
    }
  };

  template <>
  class VerilatorOutputBus<bool> : public VerilatorOutput, public VerilatorBus<bool>, public OutputBus<bool> {
  public:
    VerilatorOutputBus(uint8_t& wire) : VerilatorBus<bool>(wire) {}
    virtual ~VerilatorOutputBus() = default;

    virtual void Expect(const bool expected) {
      EXPECT_EQ(this->wire, expected);
    }

    virtual void Assert(const bool expected) {
      ASSERT_EQ(this->wire, expected);
    }
  };

  template <std::size_t SIZE>
  class VerilatorOutputBus<VlWide<SIZE>> : public VerilatorOutput, public VerilatorBus<VlWide<SIZE>>, public OutputBus<VlWide<SIZE>> {
  public:
    VerilatorOutputBus(VlWide<SIZE> wire) : VerilatorBus<VlWide<SIZE>>(wire) {}
    virtual ~VerilatorOutputBus() = default;

    virtual void Expect(const VlWide<SIZE> expected) {
      for (int i = 0; i < SIZE; i++) {
        EXPECT_EQ(this->wire[i], expected[i]);
      }
    }

    virtual void Assert(const VlWide<SIZE> expected) {
      for (int i = 0; i < SIZE; i++) {
        ASSERT_EQ(this->wire[i], expected[i]);
      }
    }
  };
}