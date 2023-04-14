#include "cores/cores.h"

#include "device-input-port.h"

#pragma once

namespace cores {
  class DeviceReset : public DeviceInputPort<bool> {
  };
}