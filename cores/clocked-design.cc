#include "clocked-design.h"

namespace cores {
  void ClockedDesign::Tick() {
      ToggleClock();
      Eval();

      ToggleClock();
      Eval();
  }

  void ClockedDesign::Tick(const int ticks) {
    for (int i = 0; i < ticks; i++) {
      Tick();
    }
  }

  void ClockedDesign::Reset() {
    ResetStart();
    ResetComplete();
  }

  void ClockedDesign::Reset(const int ticks) {
    ResetStart();
  }
}