#include <gtest/gtest.h>

#include "verilator-bus-test.h"

namespace cores {
  void VerilatorBusTest::SetUp() {
    unsigned seed = std::chrono::system_clock::now().time_since_epoch().count();
    generator.seed(seed);
  }

  void VerilatorBusTest::TearDown() {
    fixtures.final();
  }

  TEST_F(VerilatorBusTest, ExpectXSmall) {
    auto value = distribution_xsmall(generator) & 0x0F;

    xsmall_input_bus.Set(value);
    fixtures.eval();
    xsmall_output_bus.Expect(value);
  }

  TEST_F(VerilatorBusTest, AssertXSmall) {
    auto value = distribution_xsmall(generator) & 0x0F;

    xsmall_input_bus.Set(value);
    fixtures.eval();
    xsmall_output_bus.Assert(value);
  }

  TEST_F(VerilatorBusTest, ExpectSmall) {
    auto value = distribution_small(generator) & 0x0FFF;

    small_input_bus.Set(value);
    fixtures.eval();
    small_output_bus.Expect(value);
  }

  TEST_F(VerilatorBusTest, AssertSmall) {
    auto value = distribution_small(generator) & 0x0FFF;

    small_input_bus.Set(value);
    fixtures.eval();
    small_output_bus.Assert(value);
  }

  TEST_F(VerilatorBusTest, ExpectMedium) {
    auto value = distribution_medium(generator) & 0x00FFFFFF;

    medium_input_bus.Set(value);
    fixtures.eval();
    medium_output_bus.Expect(value);
  }

  TEST_F(VerilatorBusTest, AssertMedium) {
    auto value = distribution_medium(generator) & 0x00FFFFFF;

    medium_input_bus.Set(value);
    fixtures.eval();
    medium_output_bus.Assert(value);
  }

  TEST_F(VerilatorBusTest, ExpectLarge) {
    auto value = distribution_large(generator) & 0x0000FFFFFFFFFFFF;

    large_input_bus.Set(value);
    fixtures.eval();
    large_output_bus.Expect(value);
  }

  TEST_F(VerilatorBusTest, AssertLarge) {
    auto value = distribution_large(generator) & 0x0000FFFFFFFFFFFF;

    large_input_bus.Set(value);
    fixtures.eval();
    large_output_bus.Assert(value);
  }

  TEST_F(VerilatorBusTest, ExpectXLarge) {
    VlWide<3> value{
    /* value[0] = */ distribution_medium(generator), /* ; */
    /* value[1] = */ distribution_medium(generator), /* ; */
    /* value[2] = */ distribution_medium(generator) & 0x00FFFFFF /* ; */
    };

    xlarge_input_bus.Set(value);
    fixtures.eval();
    xlarge_output_bus.Expect(value);
  }

  TEST_F(VerilatorBusTest, AssertXLarge) {
    VlWide<3> value{
    /* value[0] = */ distribution_medium(generator), /* ; */
    /* value[1] = */ distribution_medium(generator), /* ; */
    /* value[2] = */ distribution_medium(generator) & 0x00FFFFFF /* ; */
    };

    xlarge_input_bus.Set(value);
    fixtures.eval();
    xlarge_output_bus.Assert(value);
  }
}