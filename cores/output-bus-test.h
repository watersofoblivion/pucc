#pragma once

#include <random>

#include <gtest/gtest.h>

#include "output-bus.h"

#include "test-output-bus.h"

namespace cores {
  class OutputBusTest : public ::testing::Test {
  protected:
    std::default_random_engine generator;
    std::uniform_int_distribution<int> distribution;

    TestOutputBus test_bus;
    OutputBus<int>& bus = test_bus;

    void SetUp() final;
  };
}