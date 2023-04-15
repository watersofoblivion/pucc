#include "clocked-design.h"

namespace cores {
  void ClockedDesign::ClockHigh() {
    clk.SetHigh();
  }

  void ClockedDesign::ClockLow() {
    clk.SetLow();
  }

  void ClockedDesign::Tick() {
      ClockHigh();
      Eval();

      ClockLow();
      Eval();
  }

  void ClockedDesign::Tick(const int ticks) {
    for (int i = 0; i < ticks; i++) {
      Tick();
    }
  }
}