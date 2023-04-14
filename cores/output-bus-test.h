#include <cstdint>

#include <gtest/gtest.h>

#include "output-bus.h"

#include "test-output-bus.h"

#pragma once

namespace cores {
  class OutputBusTest : public ::testing::Test {
  protected:
    TestOutputBus test_bus;
    OutputBus<int>& bus = test_bus;
  };
}