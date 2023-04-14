#pragma once

#include <cstdint>

#include <gtest/gtest.h>

#include "cores/cores.h"


namespace cores {
  class DeviceOutputPortTest : public ::testing::Test {
  protected:
    OutputPort<int>* port;

    void SetUp() final;
    void TearDown() final;
  };
}