#pragma once

#include <cstdint>

#include <gtest/gtest.h>

#include "cores/cores.h"

#include "verilated-port.h"

namespace cores {
  class VerilatedPortTest : public ::testing::Test {
  protected:
    Port* port;

    void SetUp() final;
    void TearDown() final;
  };
}