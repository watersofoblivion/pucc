#pragma once

#include "cores/cores.h"

#include "device-input-port.h"

namespace cores {
  class DeviceClock : public DeviceInputPort<bool> {
    void Toggle();
  };
}