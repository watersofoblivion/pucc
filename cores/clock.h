#include "input-port.h"

#pragma once

namespace cores {
  class Clock : public InputPort<bool> {
    void Toggle();
  };
}