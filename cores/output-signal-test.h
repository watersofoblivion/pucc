#pragma once

#include <gtest/gtest.h>

#include "output-signal.h"

#include "test-output-signal.h"

namespace cores {
  class OutputSignalTest : public ::testing::Test {
  protected:
    TestOutputSignal test_signal;
    OutputSignal& signal = test_signal;
  };
}