#pragma once

#include "cores/cores.h"

namespace cores {
  class VerilatedPort : public Port {
  public:
    virtual ~VerilatedPort() = default;
  };
}