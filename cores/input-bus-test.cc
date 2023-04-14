#include <random>
#include <cstdint>

#include <gtest/gtest.h>

#include "input-bus.h"

#include "test-input-bus.h"
#include "input-bus-test.h"

namespace cores {
  TEST_F(InputBusTest, Set) {
    std::default_random_engine generator;
    std::uniform_int_distribution<int> distribution;

    auto value = distribution(generator);
    bus.Set(value);

    test_bus.Expect(value);
  }
}
