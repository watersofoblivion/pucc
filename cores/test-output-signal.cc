#include <gtest/gtest.h>

#include "test-output-signal.h"

namespace cores {
  void TestOutputSignal::Set(const bool actual) {
    this->actual = actual;
  }

  void TestOutputSignal::Expect(const bool expected) {
    EXPECT_EQ(actual, expected);
  }

  void TestOutputSignal::Assert(const bool expected) {
    ASSERT_EQ(actual, expected);
  }
}