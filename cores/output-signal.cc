#include "output-signal.h"

namespace cores {
  void OutputSignal::ExpectHigh() {
    Expect(true);
  }

  void OutputSignal::ExpectLow() {
    Expect(false);
  }

  void OutputSignal::AssertHigh() {
    Assert(true);
  }

  void OutputSignal::AssertLow() {
    Assert(false);
  }
}