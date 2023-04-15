#pragma once

#include <gtest/gtest.h>

#include "cores/cores.h"


namespace cores {
  class VerilatedOutputBusTest : public ::testing::Test {
  protected:
    OutputBus<int>& bus;
  };
}