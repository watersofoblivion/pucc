#include <cstdint>

#include <gtest/gtest.h>

#include "output-port.h"

#include "test-output-port.h"

#pragma once

namespace cores {
  class OutputPortTest : public ::testing::Test {
  protected:
    OutputPort<int>* port;
    TestOutputPort* internal;

    void SetUp() final;
    void TearDown() final;
  };
}