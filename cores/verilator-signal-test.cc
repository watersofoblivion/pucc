#include <gtest/gtest.h>

#include "verilator-signal-test.h"

namespace cores {
  void VerilatorSignalTest::TearDown() {
    fixtures.final();
  }

  TEST_F(VerilatorSignalTest, Expect) {
    input_signal.Set(true);
    fixtures.eval();
    output_signal.Expect(true);
  }

  TEST_F(VerilatorSignalTest, ExpectAsserted) {
    input_signal.Assert();
    fixtures.eval();
    output_signal.ExpectAsserted();
  }

  TEST_F(VerilatorSignalTest, ExpectDeasserted) {
    input_signal.Deassert();
    fixtures.eval();
    output_signal.ExpectDeasserted();
  }

  TEST_F(VerilatorSignalTest, Assert) {
    input_signal.Set(true);
    fixtures.eval();
    output_signal.Assert(true);
  }

  TEST_F(VerilatorSignalTest, AssertAsserted) {
    input_signal.Assert();
    fixtures.eval();
    output_signal.AssertAsserted();
  }

  TEST_F(VerilatorSignalTest, AssertDeasserted) {
    input_signal.Deassert();
    fixtures.eval();
    output_signal.AssertDeasserted();
  }
}