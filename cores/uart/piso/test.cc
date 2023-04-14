#include <memory>

#include <gtest/gtest.h>
#include <verilated.h>

#include "cores/cores.h"
#include "cores/verilated.h"

#include "VPiso.h"
#include "test.h"

namespace cores::uart {
  PisoDut::PisoDut() {
    dut = std::unique_ptr<VPiso>(new VPiso("PISO DUT"));
  }

  ~PisoDut::PisoDut() {
    dut->final();
  }

  cores::Clock& PisoDut::Clock() {
    return this.clk;
  }

  Reset& PisoDut::Reset() {
    return this.rst;
  }

  InputPort& PisoDut::InputValid() {
    return this.input_valid;
  }

  InputPort& PisoDut::InputData() {
    return this.input_data;
  }

  OutputPort& PisoDut::InputReady() {
    return this.input_ready;
  }

  OutputPort& PisoDut::OutputValid() {
    return this.output_valid;
  }

  OutputPort& PisoDut::OutputBit() {
    return this.output_bit;
  }

  InputPort& PisoDut::InputReady() {
    return this.input_ready;
  }

  TEST_F(PisoTest, Reset) {
    dut.Reset().Reset();
    dut.Clock().Tick();

    dut.InputReady().Expect(1);
    dut.OutputValid().Expect(0);
  }

  TEST_F(PisoTest, DoesntLoadWhenNotReady) {
    dut.OutputValid().Assert(0);

    dut.InputValid().Set(1);
    dut.InputData().Set(0xFF);

    dut.Clock().Tick();

    dut.OutputValid().Expect(0);
  }
}