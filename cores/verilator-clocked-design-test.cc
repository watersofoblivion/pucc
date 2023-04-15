#include <random>
#include <chrono>

#include <gtest/gtest.h>

#include "verilator-clocked-design-test.h"

namespace cores {
  void VerilatorClockedDesignTest::SetUp() {
    unsigned seed = std::chrono::system_clock::now().time_since_epoch().count();
    generator.seed(seed);
  }

  void VerilatorClockedDesignTest::TearDown() {
    design.Finalize();
  }

  TEST_F(VerilatorClockedDesignTest, Tick) {
    count.Assert(0);

    design.Tick();
    count.Expect(1);

    design.Tick();
    count.Expect(2);
  }

  TEST_F(VerilatorClockedDesignTest, TickN) {
    count.Assert(0);

    design.Tick(5);
    count.Expect(5);
  }

  TEST_F(VerilatorClockedDesignTest, ClockHighLow) {
    count.Assert(0);

    design.ClockHigh();
    design.Eval();

    design.ClockLow();
    design.Eval();
    count.Expect(1);

    design.ClockHigh();
    design.Eval();
    count.Expect(2);

    design.ClockLow();
    design.Eval();
    count.Expect(2);
  }
}