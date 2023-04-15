#pragma once

#include <cstdint>
#include <random>

#include <verilated.h>
#include <gtest/gtest.h>

#include "cores/cores.h"
#include "cores/verilator.h"

#include "VVerilatorFixtures.h"

namespace cores {
  class VerilatorBusTest : public ::testing::Test {
  protected:
    std::default_random_engine generator;
    std::uniform_int_distribution<uint8_t> distribution_xsmall;
    std::uniform_int_distribution<uint16_t> distribution_small;
    std::uniform_int_distribution<uint32_t> distribution_medium;
    std::uniform_int_distribution<uint64_t> distribution_large;

    VVerilatorFixtures fixtures;

    InputBus<uint8_t>& xsmall_input_bus = verilator_xsmall_input_bus;
    InputBus<uint16_t>& small_input_bus = verilator_small_input_bus;
    InputBus<uint32_t>& medium_input_bus = verilator_medium_input_bus;
    InputBus<uint64_t>& large_input_bus = verilator_large_input_bus;
    InputBus<VlWide<3>>& xlarge_input_bus = verilator_xlarge_input_bus;

    OutputBus<uint8_t>& xsmall_output_bus = verilator_xsmall_output_bus;
    OutputBus<uint16_t>& small_output_bus = verilator_small_output_bus;
    OutputBus<uint32_t>& medium_output_bus = verilator_medium_output_bus;
    OutputBus<uint64_t>& large_output_bus = verilator_large_output_bus;
    OutputBus<VlWide<3>>& xlarge_output_bus = verilator_xlarge_output_bus;

    void SetUp() final;
    void TearDown() final;

  private:
    VerilatorInputBus<uint8_t> verilator_xsmall_input_bus{fixtures.xsmall_input_bus};
    VerilatorInputBus<uint16_t> verilator_small_input_bus{fixtures.small_input_bus};
    VerilatorInputBus<uint32_t> verilator_medium_input_bus{fixtures.medium_input_bus};
    VerilatorInputBus<uint64_t> verilator_large_input_bus{fixtures.large_input_bus};
    VerilatorInputBus<VlWide<3>> verilator_xlarge_input_bus{fixtures.xlarge_input_bus};

    VerilatorOutputBus<uint8_t> verilator_xsmall_output_bus{fixtures.xsmall_output_bus};
    VerilatorOutputBus<uint16_t> verilator_small_output_bus{fixtures.small_output_bus};
    VerilatorOutputBus<uint32_t> verilator_medium_output_bus{fixtures.medium_output_bus};
    VerilatorOutputBus<uint64_t> verilator_large_output_bus{fixtures.large_output_bus};
    VerilatorOutputBus<VlWide<3>> verilator_xlarge_output_bus{fixtures.xlarge_output_bus};
  };
}