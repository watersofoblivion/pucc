#include <memory>

#include <gtest/gtest.h>
#include <verilated.h>

#include "cores/cores.h"

#include "VSipo.h"

#pragma once

namespace cores::uart {
  class SipoDut {
    const std::unique_ptr<VSipo> dut;
    const Clock clk;
    const Reset rst;

    const InputPort input_valid;
    const InputPort input_data;
    const OutputPort input_ready;

    const OutputPort output_valid;
    const OutputPort output_bit;
    const InputPort input_ready;

  public:
    SipoDut();
    ~SipoDut();

    Clock& Clock();
    Reset& Reset();

    InputPort& InputValid();
    InputPort& InputData();
    OutputPort& InputReady();

    OutputPort& OutputValid();
    OutputPort& OutputBit();
    InputPort& InputReady();
  };

  class SipoTest : public ::testing::Test {
  protected:
    SipoDut dut;

    void SetUp() override;
    void TearDown() override;
  };
}