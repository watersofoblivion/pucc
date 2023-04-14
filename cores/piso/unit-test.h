#include <memory>

#include <gtest/gtest.h>
#include <verilated.h>

#include "cores/cores.h"

#include "VPiso.h"

#pragma once

namespace cores::uart {
  class PisoDut {
    const std::unique_ptr<VPiso> dut;
    const Clock clk;
    const Reset rst;

    const InputPort input_valid;
    const InputPort input_data;
    const OutputPort input_ready;

    const OutputPort output_valid;
    const OutputPort output_bit;
    const InputPort input_ready;

  public:
    PisoDut();
    ~PisoDut();

    Clock& Clock();
    Reset& Reset();

    InputPort& InputValid();
    InputPort& InputData();
    OutputPort& InputReady();

    OutputPort& OutputValid();
    OutputPort& OutputBit();
    InputPort& InputReady();
  };

  class PisoTest : public ::testing::Test {
  protected:
    PisoDut dut;

    void SetUp() override;
    void TearDown() override;
  };
}