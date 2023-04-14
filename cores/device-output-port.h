#include <cstdint>

#include "cores/cores.h"

#include "device-bus.h"

#pragma once

namespace cores {
  template <typename WIDTH>
  class DeviceOutputBus : public DeviceBus {
  public:
    virtual ~DeviceOutputBus() = default;

    virtual WIDTH Get() = 0;
  };
}