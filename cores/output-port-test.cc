#include <random>
#include <cstdint>

#include <gtest/gtest.h>

#include "output-port.h"

#include "test-output-port.h"
#include "output-port-test.h"

namespace cores {
  void OutputPortTest::SetUp() {
    internal = new TestOutputPort();
    port = internal;
  }

  void OutputPortTest::TearDown() {
    delete port;
  }

  TEST_F(OutputPortTest, Get) {
    std::default_random_engine generator;
    std::uniform_int_distribution<int> distribution;
    
    auto value = distribution(generator);

    internal->Set(value);
    ASSERT_EQ(port->Get(), value);
  }
}