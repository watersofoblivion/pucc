#include <chrono>

#include <gtest/gtest.h>

#include "input-bus-test.h"

namespace cores {
  void InputBusTest::SetUp() {
    unsigned seed = std::chrono::system_clock::now().time_since_epoch().count();
    generator.seed(seed);
  }

  TEST_F(InputBusTest, Set) {
    auto value = distribution(generator);
    bus.Set(value);

    test_bus.Expect(value);
  }
}
