#pragma once

#include <cstdint>

#include <gtest/gtest.h>

#include "cores/cores.h"


namespace cores {
  class VerilatedOutputSignalTest : public ::testing::Test {
  protected:
    OutputSignal<int>* port;

    void SetUp() final;
    void TearDown() final;
  };
}