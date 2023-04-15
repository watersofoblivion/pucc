#include <gtest/gtest.h>

#include "verilated-bus-test.h"

namespace cores {
  TEST_F(VerilatedBusTest, ExpectXSmall) {
    auto value = distribution_xsmall(generator) & 0x0F;

    xsmall_input_bus.Set(value);
    fixtures.eval();
    xsmall_output_bus.Expect(value);
  }

  TEST_F(VerilatedBusTest, AssertXSmall) {
    auto value = distribution_xsmall(generator) & 0x0F;

    xsmall_input_bus.Set(value);
    fixtures.eval();
    xsmall_output_bus.Assert(value);
  }

  TEST_F(VerilatedBusTest, ExpectSmall) {
    auto value = distribution_small(generator) & 0x0FFF;

    small_input_bus.Set(value);
    fixtures.eval();
    small_output_bus.Expect(value);
  }

  TEST_F(VerilatedBusTest, AssertSmall) {
    auto value = distribution_small(generator) & 0x0FFF;

    small_input_bus.Set(value);
    fixtures.eval();
    small_output_bus.Assert(value);
  }

  TEST_F(VerilatedBusTest, ExpectMedium) {
    auto value = distribution_medium(generator) & 0x00FFFFFF;

    medium_input_bus.Set(value);
    fixtures.eval();
    medium_output_bus.Expect(value);
  }

  TEST_F(VerilatedBusTest, AssertMedium) {
    auto value = distribution_medium(generator) & 0x00FFFFFF;

    medium_input_bus.Set(value);
    fixtures.eval();
    medium_output_bus.Assert(value);
  }

  TEST_F(VerilatedBusTest, ExpectLarge) {
    auto value = distribution_large(generator) & 0x0000FFFFFFFFFFFF;

    large_input_bus.Set(value);
    fixtures.eval();
    large_output_bus.Expect(value);
  }

  TEST_F(VerilatedBusTest, AssertLarge) {
    auto value = distribution_large(generator) & 0x0000FFFFFFFFFFFF;

    large_input_bus.Set(value);
    fixtures.eval();
    large_output_bus.Assert(value);
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