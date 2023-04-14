#include <cstdint>

#include "cores/cores.h"

#include "device-port.h"

#pragma once

namespace cores {
  template <typename WIDTH>
  class DeviceInputPort : public DevicePort {
  public:
    virtual ~DeviceInputPort() = default;

    virtual void Set(const WIDTH) = 0;
  };
}