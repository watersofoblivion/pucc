#include "input-signal.h"

namespace cores {
  void InputSignal::Assert() {
    Set(true);
  }

  void InputSignal::Deassert() {
    Set(false);
  }
}