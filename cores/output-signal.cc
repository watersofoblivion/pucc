#include "output-signal.h"

namespace cores {
  void OutputSignal::ExpectAsserted() {
    Expect(true);
  }

  void OutputSignal::ExpectDeasserted() {
    Expect(false);
  }

  void OutputSignal::AssertAsserted() {
    Assert(true);
  }

  void OutputSignal::AssertDeasserted() {
    Assert(false);
  }
}