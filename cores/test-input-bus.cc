#include <gtest/gtest.h>

#include "test-input-bus.h"

namespace cores {
  void TestInputBus::Set(const int actual) {
    this->actual = actual;
  }

  void TestInputBus::Expect(const int expected) {
    EXPECT_EQ(actual, expected);
  }
}