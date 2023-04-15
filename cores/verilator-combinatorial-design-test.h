#pragma once

#include <cstdint>
#include <random>

#include <gtest/gtest.h>
#include <verilated.h>

#include "cores/cores.h"
#include "cores/verilator.h"

#include "VVerilatorFixtures.h"

namespace cores {
  class VerilatorCombinatorialDesignTest : public ::testing::Test {
  protected:
    std::default_random_engine generator;
    std::uniform_int_distribution<uint32_t> distribution;

    InputBus<uint32_t>& lhs = verilator_lhs;
    InputBus<uint32_t>& rhs = verilator_rhs;
    OutputBus<uint32_t>& sum = verilator_sum;
    OutputSignal& finalized = verilator_finalized;

    CombinatorialDesign& design = verilator_design;

    void SetUp() final;
    void TearDown() final;

  private:
    VVerilatorFixtures fixtures;

    VerilatorInputBus<uint32_t> verilator_lhs{fixtures.lhs};
    VerilatorInputBus<uint32_t> verilator_rhs{fixtures.rhs};
    VerilatorOutputBus<uint32_t> verilator_sum{fixtures.sum};
    VerilatorOutputSignal verilator_finalized{fixtures.finalized};

    VerilatorCombinatorialDesign<VVerilatorFixtures> verilator_design{fixtures};
  };
}