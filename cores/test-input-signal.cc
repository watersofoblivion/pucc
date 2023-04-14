#include <cstdint>

#include <gtest/gtest.h>

#include "input-signal.h"
#include "test-input-signal.h"

namespace cores {
  void TestInputSignal::Set(const bool actual) {
    this->actual = actual;
  }

  void TestInputSignal::Expect(const bool expected) {
    EXPECT_EQ(actual, expected);
  }
}