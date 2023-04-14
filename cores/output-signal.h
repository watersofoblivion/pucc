#pragma once

#include <cstdint>

#include "signal.h"
#include "output-bus.h"

namespace cores {
  class OutputSignal : public Signal, public OutputBus<bool> {
  public:
    virtual ~OutputSignal() = default;

    void ExpectHigh();
    void ExpectLow();

    void AssertHigh();
    void AssertLow();
  };
}