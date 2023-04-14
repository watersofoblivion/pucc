#pragma once

#include "port.h"
#include "bus.h"

namespace cores {
  class Signal : public Bus<bool> {
  public:
    virtual ~Signal() = default;
  };
}