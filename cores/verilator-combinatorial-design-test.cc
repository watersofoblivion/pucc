#include <chrono>

#include <gtest/gtest.h>

#include "verilator-combinatorial-design-test.h"

namespace cores {
  void VerilatorCombinatorialDesignTest::SetUp() {
    unsigned seed = std::chrono::system_clock::now().time_since_epoch().count();
    generator.seed(seed);
  }

  void VerilatorCombinatorialDesignTest::TearDown() {
    design.Finalize();
  }

  TEST_F(VerilatorCombinatorialDesignTest, Eval) {
    auto lhs_value = distribution(generator);
    auto rhs_value = distribution(generator);
    auto sum_value = lhs_value + rhs_value;

    lhs.Set(lhs_value);
    rhs.Set(rhs_value);
    design.Eval();
    sum.Expect(sum_value);

    lhs_value = distribution(generator);
    rhs_value = distribution(generator);
    lhs.Set(lhs_value);
    rhs.Set(rhs_value);

    sum.Assert(sum_value);
    design.Eval();
    sum.Expect(lhs_value + rhs_value);
  }

  TEST_F(VerilatorCombinatorialDesignTest, Finalize) {
    design.Eval();
    finalized.ExpectDeasserted();

    design.Finalize();
    finalized.ExpectAsserted();
  }
}