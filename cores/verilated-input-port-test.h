#pragma once

#include <cstdint>

#include <gtest/gtest.h>

#include "cores/cores.h"

namespace cores {
  class VerilatedInputPortTest : public ::testing::Test {
  protected:
    InputPort<int>* port;

    void SetUp() final;
    void TearDown() final;
  };
}