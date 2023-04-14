#pragma once

#include <cstdint>

#include <gtest/gtest.h>

#include "cores/cores.h"

#include "device-port.h"

namespace cores {
  class DevicePortTest : public ::testing::Test {
  protected:
    Port* port;

    void SetUp() final;
    void TearDown() final;
  };
}