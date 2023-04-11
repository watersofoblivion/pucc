#include <cstdint>

#include <gtest/gtest.h>

#include "input-port.h"

#include "test-input-port.h"

#pragma once

namespace cores {
  class InputPortTest : public ::testing::Test {
  protected:
    InputPort<int>* port;
    TestInputPort* internal;

    void SetUp() final;
    void TearDown() final;
  };
}