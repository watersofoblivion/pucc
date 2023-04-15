#pragma once

#include "cores/cores.h"

namespace cores {
  class VerilatorPort : public Port {
  public:
    virtual ~VerilatorPort() = default;
  };
}