#pragma once

#include <memory>

#include <gtest/gtest.h>
#include <verilated.h>

#include "cores/cores.h"

#include "VPiso.h"

namespace cores::uart {
  class PisoDut : public ClockedDesign {
    const InputSignal& input_valid;
    const InputBus<uint8_t>& input_data;
    const OutputSignal& input_ready;

    const OutputSignal& output_valid;
    const OutputSignal& output_bit;
    const InputSignal& output_ready;

  public:
    ~PisoDut() = default;

    InputSignal& InputValid();
    InputBus<uint8_t>& InputData();
    OutputSignal& InputReady();

    OutputSignal& OutputValid();
    OutputSignal& OutputBit();
    InputSignal& OutputReady();
  };

  class PisoTest : public ClockedDesignTest<PisoDut> {
  };
}