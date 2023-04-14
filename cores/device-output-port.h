#include <cstdint>

#include "cores/cores.h"

#include "device-port.h"

#pragma once

namespace cores {
  template <typename WIDTH>
  class DeviceOutputPort : public DevicePort {
  public:
    virtual ~DeviceOutputPort() = default;

    virtual WIDTH Get() = 0;
  };
}