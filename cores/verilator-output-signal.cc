#include <cstdint>

#include <gtest/gtest.h>

#include "verilator-signal.h"
#include "verilator-output-signal.h"

namespace cores {
  VerilatorOutputSignal::VerilatorOutputSignal(uint8_t& wire) : VerilatorSignal(wire) {
  }

  void VerilatorOutputSignal::Expect(const bool expected) {
    EXPECT_EQ(wire, expected);
  }

  void VerilatorOutputSignal::Assert(const bool expected) {
    ASSERT_EQ(wire, expected);    
  }
}