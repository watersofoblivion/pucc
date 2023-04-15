#pragma once

#include <cstdint>
#include <random>

#include <gtest/gtest.h>
#include <verilated.h>

#include "cores/cores.h"
#include "cores/verilator.h"

#include "VVerilatorFixtures.h"

namespace cores {
  class VerilatorClockedDesignTest : public ::testing::Test {
  protected:
    std::default_random_engine generator;
    std::uniform_int_distribution<uint32_t> distribution;

    OutputBus<uint8_t>& count = verilator_count;
    ClockedDesign& design = verilator_design;

    void SetUp() final;
    void TearDown() final;

  private:
    VVerilatorFixtures fixtures;

    VerilatorInputSignal clk{fixtures.clk};
    VerilatorOutputBus<uint8_t> verilator_count{fixtures.count};
    VerilatorClockedDesign<VVerilatorFixtures> verilator_design{fixtures, clk};
  };
}