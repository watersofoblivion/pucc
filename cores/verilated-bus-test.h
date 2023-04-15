#pragma once

#include <cstdint>
#include <random>

#include <gtest/gtest.h>

#include "cores/cores.h"

#include "verilated.h"
#include "VVerilatedFixtures.h"

namespace cores {
  class VerilatedBusTest : public ::testing::Test {
  protected:
    std::default_random_engine generator;
    std::uniform_int_distribution<uint8_t> distribution_xsmall;
    std::uniform_int_distribution<uint16_t> distribution_small;
    std::uniform_int_distribution<uint32_t> distribution_medium;
    std::uniform_int_distribution<uint64_t> distribution_large;

    VVerilatedFixtures fixtures;

    InputBus<uint8_t>& xsmall_input_bus = verilated_xsmall_input_bus;
    InputBus<uint16_t>& small_input_bus = verilated_small_input_bus;
    InputBus<uint32_t>& medium_input_bus = verilated_medium_input_bus;
    InputBus<uint64_t>& large_input_bus = verilated_large_input_bus;
    // InputBus<VlWide<3>>& xlarge_input_bus = verilated_xlarge_input_bus;

    OutputBus<uint8_t>& xsmall_output_bus = verilated_xsmall_output_bus;
    OutputBus<uint16_t>& small_output_bus = verilated_small_output_bus;
    OutputBus<uint32_t>& medium_output_bus = verilated_medium_output_bus;
    OutputBus<uint64_t>& large_output_bus = verilated_large_output_bus;
    // OutputBus<VlWide<3>>& xlarge_output_bus = verilated_xlarge_output_bus;

  private:
    VerilatedInputBus<uint8_t> verilated_xsmall_input_bus{fixtures.xsmall_input_bus};
    VerilatedInputBus<uint16_t> verilated_small_input_bus{fixtures.small_input_bus};
    VerilatedInputBus<uint32_t> verilated_medium_input_bus{fixtures.medium_input_bus};
    VerilatedInputBus<uint64_t> verilated_large_input_bus{fixtures.large_input_bus};
    // VerilatedInputBus<VlWide<3>> verilated_xlarge_input_bus{fixtures.xlarge_input_bus};

    VerilatedOutputBus<uint8_t> verilated_xsmall_output_bus{fixtures.xsmall_output_bus};
    VerilatedOutputBus<uint16_t> verilated_small_output_bus{fixtures.small_output_bus};
    VerilatedOutputBus<uint32_t> verilated_medium_output_bus{fixtures.medium_output_bus};
    VerilatedOutputBus<uint64_t> verilated_large_output_bus{fixtures.large_output_bus};
    // VerilatedOutputBus<VlWide<3>> verilated_xlarge_output_bus{fixtures.xlarge_output_bus};
  };
}