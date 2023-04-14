#include <cstdint>

#include "cores/cores.h"

#include "device-bus.h"

#pragma once

namespace cores {
  template <typename WIDTH>
  class DeviceInputBus : public DeviceBus {
  public:
    virtual ~DeviceInputBus() = default;

    virtual void Set(const WIDTH) = 0;
  };
}