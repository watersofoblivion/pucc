#pragma once

#include <gtest/gtest.h>
#include <verilated.h>

#include "cores/cores.h"
#include "cores/verilator.h"

#include "VVerilatorFixtures.h"

namespace cores {
  class VerilatorSignalTest : public ::testing::Test {
  protected:
    VVerilatorFixtures fixtures;

    InputSignal& input_signal = verilator_input_signal;
    OutputSignal& output_signal = verilator_output_signal;

    void TearDown() final;

  private:
    VerilatorInputSignal verilator_input_signal{fixtures.input_signal};
    VerilatorOutputSignal verilator_output_signal{fixtures.output_signal};
  };
}