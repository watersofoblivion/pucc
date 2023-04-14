#pragma once

#include "input-signal.h"

namespace cores {
  class Clock : public InputSignal {
    void Toggle();
  };
}