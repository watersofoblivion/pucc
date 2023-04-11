#include <cstdint>

#include <gtest/gtest.h>

#include "port.h"

#pragma once

namespace cores {
  class PortTest : public ::testing::Test {
  protected:
    Port* port;

    void SetUp() final;
    void TearDown() final;
  };
}