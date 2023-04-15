#pragma once

#include "verilated.h"

#include "cores/cores.h"

#include "verilated-port.h"

namespace cores {
  template <typename WIDTH>
  class VerilatedOutputBus : public VerilatedOutput, public VerilatedBus<WIDTH>, public OutputBus<WIDTH> {
  public:
    VerilatedOutputBus(WIDTH& wire) : VerilatedBus<WIDTH>(wire) {
    }

    virtual ~VerilatedOutputBus() = default;

    virtual void Expect(const WIDTH expected) {
      EXPECT_EQ(this->wire, expected);
    }

    virtual void Assert(const WIDTH expected) {
      ASSERT_EQ(this->wire, expected);
    }
  };

  // template <std::size_t SIZE>
  // class VerilatedOutputBus<VlWide<SIZE>> : public VerilatedOutput, public VerilatedBus<VlWide<SIZE>>, public OutputBus<VlWide<SIZE>> {
  //   VerilatedOutputBus(VlWide<SIZE> wire) : VerilatedBus<::VlWide<SIZE>>(wire) {
  //   }

  //   virtual VerilatedOutputBus() = default;

  //   virtual void Expect(const VlWide<SIZE> expected) {
  //   }

  //   virtual void Assert(const VlWide<SIZE> expected) {
  //   }
  // };
}