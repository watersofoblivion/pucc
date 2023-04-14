#pragma once

#include <cstdint>

#include <gtest/gtest.h>

#include "cores/cores.h"

namespace cores {
  class VerilatedInputSignalTest : public ::testing::Test {
  protected:
    InputSignal* port;

    void SetUp() final;
    void TearDown() final;
  };
}