#pragma once

#include <cstdint>

#include <gtest/gtest.h>

#include "cores/cores.h"


namespace cores {
  class DeviceOutputBusTest : public ::testing::Test {
  protected:
    OutputBus<int>* port;

    void SetUp() final;
    void TearDown() final;
  };
}