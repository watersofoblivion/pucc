#pragma once

#include <gtest/gtest.h>

#include "cores/cores.h"

namespace cores {
  class VerilatedInputBusTest : public ::testing::Test {
  protected:
    InputBus<int>& bus;
  };
}