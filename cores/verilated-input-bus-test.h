#pragma once

#include <cstdint>

#include <gtest/gtest.h>

#include "cores/cores.h"

namespace cores {
  class VerilatedInputBusTest : public ::testing::Test {
  protected:
    InputBus<int>* port;

    void SetUp() final;
    void TearDown() final;
  };
}