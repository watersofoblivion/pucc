#pragma once

#include <cstdint>

#include "signal.h"
#include "input-bus.h"

namespace cores {
  class InputSignal : public Signal, public InputBus<bool> {
  public:
    virtual ~InputSignal() = default;

    void SetHigh();
    void SetLow();
  };
}