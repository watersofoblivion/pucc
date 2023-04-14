#include <memory>

#include <gtest/gtest.h>
#include <verilated.h>

#include "cores/cores.h"
#include "cores/verilated.h"

#include "VSipo.h"
#include "test.h"

namespace cores::uart {
  SipoDut::SipoDut() {
    dut = std::unique_ptr<VSipo>(new VSipo("PISO DUT"));
  }

  ~SipoDut::SipoDut() {
    dut->final();
  }

  cores::Clock& SipoDut::Clock() {
    return this.clk;
  }

  Reset& SipoDut::Reset() {
    return this.rst;
  }

  InputPort& SipoDut::InputValid() {
    return this.input_valid;
  }

  InputPort& SipoDut::InputData() {
    return this.input_data;
  }

  OutputPort& SipoDut::InputReady() {
    return this.input_ready;
  }

  OutputPort& SipoDut::OutputValid() {
    return this.output_valid;
  }

  OutputPort& SipoDut::OutputBit() {
    return this.output_bit;
  }

  InputPort& SipoDut::InputReady() {
    return this.input_ready;
  }

  TEST_F(SipoTest, Reset) {
    dut.Reset().Reset();
    dut.Clock().Tick();

    dut.InputReady().Expect(1);
    dut.OutputValid().Expect(0);
  }

  TEST_F(SipoTest, DoesntLoadWhenNotReady) {
    dut.OutputValid().Assert(0);

    dut.InputValid().Set(1);
    dut.InputData().Set(0xFF);

    dut.Clock().Tick();

    dut.OutputValid().Expect(0);
  }
}