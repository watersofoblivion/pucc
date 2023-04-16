#include <chrono>

#include <gtest/gtest.h>

#include "output-bus-test.h"

namespace cores {
  void OutputBusTest::SetUp() {
    unsigned seed = std::chrono::system_clock::now().time_since_epoch().count();
    generator.seed(seed);
  }

  TEST_F(OutputBusTest, Expect) {
    auto value = distribution(generator);
    test_bus.Set(value);

    bus.Expect(value);
  }

  TEST_F(OutputBusTest, Assert) {
    auto value = distribution(generator);
    test_bus.Set(value);

    bus.Assert(value);
  }
}