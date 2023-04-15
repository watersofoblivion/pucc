#pragma once

#include <gtest/gtest.h>

#include "cores/cores.h"


namespace cores {
  class VerilatedOutputSignalTest : public ::testing::Test {
  protected:
    OutputSignal& signal;
  };
}