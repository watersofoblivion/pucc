#include <random>
#include <cstdint>

#include <gtest/gtest.h>

#include "input-port.h"

#include "test-input-port.h"
#include "input-port-test.h"

namespace cores {
  void InputPortTest::SetUp() {
    internal = new TestInputPort();
    port = internal;
  }

  void InputPortTest::TearDown() {
    delete port;
  }

  TEST_F(InputPortTest, Set) {
    std::default_random_engine generator;
    std::uniform_int_distribution<int> distribution;

    auto value = distribution(generator);

    port->Set(value);
    EXPECT_EQ(internal->Get(), value);
  }
}
