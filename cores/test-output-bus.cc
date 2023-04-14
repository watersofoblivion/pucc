#include <cstdint>

#include <gtest/gtest.h>

#include "test-output-bus.h"

namespace cores {
  void TestOutputBus::Set(const int actual) {
    this->actual = actual;
  }

  void TestOutputBus::Expect(const int expected) {
    EXPECT_EQ(actual, expected);
  }

  void TestOutputBus::Assert(const int expected) {
    ASSERT_EQ(actual, expected);
  }
}