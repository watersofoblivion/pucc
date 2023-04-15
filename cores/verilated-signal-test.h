#pragma once

#include <gtest/gtest.h>

#include "cores/cores.h"

#include "verilated.h"
#include "VVerilatedFixtures.h"

namespace cores {
  class VerilatedSignalTest : public ::testing::Test {
  protected:
    VVerilatedFixtures fixtures;

    InputSignal& input_signal = verilated_input_signal;
    OutputSignal& output_signal = verilated_output_signal;

  private:
    VerilatedInputSignal verilated_input_signal{fixtures.input_signal};
    VerilatedOutputSignal verilated_output_signal{fixtures.output_signal};
  };
}