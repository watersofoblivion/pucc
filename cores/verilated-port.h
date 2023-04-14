#include <cstdint>

#include "cores/cores.h"

#pragma once

namespace cores {
  class VerilatedPort : public Port {
  public:
    virtual ~VerilatedPort() = default;
  };
}