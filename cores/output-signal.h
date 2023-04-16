#pragma once

#include "signal.h"
#include "output-bus.h"

namespace cores {
  class OutputSignal : public Signal, public OutputBus<bool> {
  public:
    virtual ~OutputSignal() = default;

    void ExpectAsserted();
    void ExpectDeasserted();

    void AssertAsserted();
    void AssertDeasserted();
  };
}