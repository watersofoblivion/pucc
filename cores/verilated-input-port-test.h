#pragma once

#include <cstdint>

#include <gtest/gtest.h>

#include "cores/cores.h"

namespace cores {
  class InputPortTest : public ::testing::Test {
  protected:
    InputPort<int>* port;

    void SetUp() final;
    void TearDown() final;
  };
}