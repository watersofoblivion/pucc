#pragma once

#include <gtest/gtest.h>

#include "input-bus.h"

#include "test-input-bus.h"

namespace cores {
  class InputBusTest : public ::testing::Test {
  protected:
    TestInputBus test_bus;
    InputBus<int>& bus = test_bus;
  };
}