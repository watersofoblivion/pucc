#include <cstdint>

#include "port.h"

#pragma once

namespace cores {
  template <typename WIDTH>
  class InputPort : public Port {
  public:
    virtual ~InputPort() = default;

    virtual void Set(const WIDTH) = 0;
  };
}