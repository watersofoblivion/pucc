#pragma once

#include <gtest/gtest.h>

#include "cores/cores.h"

namespace cores {
  class VerilatedInputSignalTest : public ::testing::Test {
  protected:
    InputSignal& signal;
  };
}