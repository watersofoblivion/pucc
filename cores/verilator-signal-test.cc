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

  TEST_F(VerilatorSignalTest, ExpectHigh) {
    input_signal.Set(true);
    fixtures.eval();
    output_signal.ExpectHigh();
  }

  TEST_F(VerilatorSignalTest, ExpectLow) {
    input_signal.Set(false);
    fixtures.eval();
    output_signal.ExpectLow();
  }

  TEST_F(VerilatorSignalTest, Assert) {
    input_signal.Set(true);
    fixtures.eval();
    output_signal.Assert(true);
  }

  TEST_F(VerilatorSignalTest, AssertHigh) {
    input_signal.Set(true);
    fixtures.eval();
    output_signal.AssertHigh();
  }

  TEST_F(VerilatorSignalTest, AssertLow) {
    input_signal.Set(false);
    fixtures.eval();
    output_signal.AssertLow();
  }

  TEST_F(VerilatorSignalTest, Set) {
    input_signal.Set(true);
    fixtures.eval();
    output_signal.Expect(true);
  }

  TEST_F(VerilatorSignalTest, SetHigh) {
    input_signal.SetHigh();
    fixtures.eval();
    output_signal.Expect(true);
  }

  TEST_F(VerilatorSignalTest, SetLow) {
    input_signal.SetLow();
    fixtures.eval();
    output_signal.ExpectLow();
  }
}