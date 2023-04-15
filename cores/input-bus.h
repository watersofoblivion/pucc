#pragma once

#include "input.h"
#include "bus.h"

namespace cores {
  template <typename WIDTH>
  class InputBus : public Input, public Bus<WIDTH> {
  public:
    virtual ~InputBus() = default;

    virtual void Set(const WIDTH) = 0;
  };
}