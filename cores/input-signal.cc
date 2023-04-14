#include "input-signal.h"

namespace cores {
  void InputSignal::SetHigh() {
    Set(true);
  }

  void InputSignal::SetLow() {
    Set(false);
  }
}