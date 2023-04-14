#include <cstdint>

#include <gtest/gtest.h>

#include "output-signal.h"

#include "test-output-signal.h"

#pragma once

namespace cores {
  class OutputSignalTest : public ::testing::Test {
  protected:
    TestOutputSignal test_signal;
    OutputSignal& signal = test_signal;
  };
}