#pragma once

#include <cstdint>

#include <gtest/gtest.h>

#include "cores/cores.h"

namespace cores {
  class DeviceInputBusTest : public ::testing::Test {
  protected:
    InputBus<int>* bus;

    void SetUp() final;
    void TearDown() final;
  };
}