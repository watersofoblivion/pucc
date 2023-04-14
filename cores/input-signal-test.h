#pragma once

#include <cstdint>

#include <gtest/gtest.h>

#include "input-signal.h"

#include "test-input-signal.h"

namespace cores {
  class InputSignalTest : public ::testing::Test {
  protected:
    TestInputSignal test_signal;
    InputSignal& signal = test_signal;
  };
}