#include <cstdint>

#include "cores/cores.h"

#include "verilated-output-signal.h"

namespace cores {
  VerilatedOutputSignal::VerilatedOutputSignal(uint8_t& wire) : VerilatedSignal(wire) {
  }

  void VerilatedOutputSignal::Expect(const bool expected) {
    EXPECT_EQ(wire, expected);
  }

  void VerilatedOutputSignal::Assert(const bool expected) {
    ASSERT_EQ(wire, expected);    
  }
}