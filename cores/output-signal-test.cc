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

  TEST_F(OutputSignalTest, ExpectAsserted) {
    test_signal.Set(true);
    signal.ExpectAsserted();
  }

  TEST_F(OutputSignalTest, AssertAsserted) {
    test_signal.Set(true);
    signal.AssertAsserted();
  }

  TEST_F(OutputSignalTest, ExpectDeasserted) {
    test_signal.Set(false);
    signal.ExpectDeasserted();
  }

  TEST_F(OutputSignalTest, AssertDeasserted) {
    test_signal.Set(false);
    signal.AssertDeasserted();
  }
}