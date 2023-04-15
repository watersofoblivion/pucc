#pragma once

#include "cores/cores.h"

namespace cores {
  class VerilatedDesign : public Design {
  public:
    virtual ~VerilatedDesign() = default;
  };
}