#pragma once

#include <random>

#include <gtest/gtest.h>

#include "input-bus.h"

#include "test-input-bus.h"

namespace cores {
  class InputBusTest : public ::testing::Test {
  protected:
    std::default_random_engine generator;
    std::uniform_int_distribution<int> distribution;

    TestInputBus test_bus;
    InputBus<int>& bus = test_bus;

    void SetUp() final;
  };
}