#include <gtest/gtest.h>

#include "verilated-bus-test.h"

namespace cores {
  TEST_F(VerilatedBusTest, ExpectXSmall) {
    xsmall_input_bus.Set(0x0E);
    fixtures.eval();
    xsmall_output_bus.Expect(0x0E);
  }

  TEST_F(VerilatedBusTest, AssertXSmall) {
    xsmall_input_bus.Set(0x0E);
    fixtures.eval();
    xsmall_output_bus.Assert(0x0E);
  }

  TEST_F(VerilatedBusTest, ExpectSmall) {
    small_input_bus.Set(0x0EFF);
    fixtures.eval();
    small_output_bus.Expect(0x0EFF);
  }

  TEST_F(VerilatedBusTest, AssertSmall) {
    small_input_bus.Set(0x0EFF);
    fixtures.eval();
    small_output_bus.Assert(0x0EFF);
  }

  TEST_F(VerilatedBusTest, ExpectMedium) {
    medium_input_bus.Set(0x0EFFFFFF);
    fixtures.eval();
    medium_output_bus.Expect(0x0EFFFFFF);
  }

  TEST_F(VerilatedBusTest, AssertMedium) {
    medium_input_bus.Set(0x0EFFFFFF);
    fixtures.eval();
    medium_output_bus.Assert(0x0EFFFFFF);
  }

  TEST_F(VerilatedBusTest, ExpectLarge) {
    large_input_bus.Set(0x0EFFFFFFFFFFFFFF);
    fixtures.eval();
    large_output_bus.Expect(0x0EFFFFFFFFFFFFFF);
  }

  TEST_F(VerilatedBusTest, AssertLarge) {
    large_input_bus.Set(0x0EFFFFFFFFFFFFFF);
    fixtures.eval();
    large_output_bus.Assert(0x0EFFFFFFFFFFFFFF);
  }

  // TEST_F(VerilatedBusTest, ExpectXLarge) {
  //   VlWide<3> value;
  //   value[0] = 0x0EFFFFFF;
  //   value[1] = 0xFFFFFFFF;
  //   value[2] = 0xFFFFFFFF;

  //   xlarge_input_bus.Set(value);
  //   fixtures.eval();
  //   xlarge_output_bus.Expect(value);
  // }

  // TEST_F(VerilatedBusTest, AssertXLarge) {
  //   VlWide<3> value;
  //   value[0] = 0x0EFFFFFF;
  //   value[1] = 0xFFFFFFFF;
  //   value[2] = 0xFFFFFFFF;

  //   xlarge_input_bus.Set(value);
  //   fixtures.eval();
  //   xlarge_output_bus.Assert(value);
  // }
}