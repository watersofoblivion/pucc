#include <random>
#include <cstdint>

#include <gtest/gtest.h>

#include "output-signal.h"

#include "test-output-signal.h"
#include "output-signal-test.h"

namespace cores {
  TEST_F(OutputSignalTest, Expect) {
    test_signal.Set(true);
    signal.Expect(true);
  }

  TEST_F(OutputSignalTest, Assert) {
    test_signal.Set(true);
    signal.Assert(true);
  }

  TEST_F(OutputSignalTest, ExpectHigh) {
    test_signal.Set(true);
    signal.ExpectHigh();
  }

  TEST_F(OutputSignalTest, AssertHigh) {
    test_signal.Set(true);
    signal.AssertHigh();
  }

  TEST_F(OutputSignalTest, ExpectLow) {
    test_signal.Set(false);
    signal.ExpectLow();
  }

  TEST_F(OutputSignalTest, AssertLow) {
    test_signal.Set(false);
    signal.AssertLow();
  }
}