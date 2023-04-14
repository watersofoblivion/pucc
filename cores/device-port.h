#include <cstdint>

#include "cores/cores.h"

#pragma once

namespace cores {
  class DevicePort : public Port {
  public:
    virtual ~DevicePort() = default;
  };
}