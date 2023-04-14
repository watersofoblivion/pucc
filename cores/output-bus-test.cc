#include <random>
#include <cstdint>

#include <gtest/gtest.h>

#include "output-bus.h"

#include "test-output-bus.h"
#include "output-bus-test.h"

namespace cores {
  TEST_F(OutputBusTest, Expect) {
    std::default_random_engine generator;
    std::uniform_int_distribution<int> distribution;
    
    auto value = distribution(generator);
    test_bus.Set(value);

    bus.Expect(value);
  }

  TEST_F(OutputBusTest, Assert) {
    std::default_random_engine generator;
    std::uniform_int_distribution<int> distribution;
    
    auto value = distribution(generator);
    test_bus.Set(value);

    bus.Assert(value);
  }
}