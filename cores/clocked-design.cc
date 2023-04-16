#include "clocked-design.h"

namespace cores {
  void ClockedDesign::AssertClock() {
    clk.Assert();
  }

  void ClockedDesign::DeassertClock() {
    clk.Deassert();
  }

  void ClockedDesign::Tick() {
      AssertClock();
      Eval();

      DeassertClock();
      Eval();
  }

  void ClockedDesign::Tick(const int ticks) {
    for (int i = 0; i < ticks; i++) {
      Tick();
    }
  }
}