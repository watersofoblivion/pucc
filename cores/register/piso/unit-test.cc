#include <memory>

#include <gtest/gtest.h>
#include <verilated.h>

#include "cores/cores.h"
// #include "cores/verilated.h"

#include "VPiso.h"
#include "unit-test.h"

namespace cores::uart {
  PisoDut::PisoDut() {
  }

  InputSignal& PisoDut::InputValid() {
    return input_valid;
  }

  InputBus<uint8_t>& PisoDut::InputData() {
    return input_data;
  }

  OutputSignal& PisoDut::InputReady() {
    return input_ready;
  }

  OutputSignal& PisoDut::OutputValid() {
    return output_valid;
  }

  OutputSignal& PisoDut::OutputBit() {
    return output_bit;
  }

  InputSignal& PisoDut::OutputReady() {
    return output_ready;
  }

  TEST_F(PisoTest, Reset) {
    dut.Reset();

    dut.InputReady().Expect(1);
    dut.OutputValid().Expect(0);
  }

  TEST_F(PisoTest, DoesntLoadWhenNotReady) {
    dut.OutputValid().Assert(0);

    dut.InputValid().Set(1);
    dut.InputData().Set(0xFF);

    dut.Tick();

    dut.OutputValid().Expect(0);
  }
}