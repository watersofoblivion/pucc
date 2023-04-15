#pragma once

#include "cores/cores.h"
#include "verilator-design.h"

namespace cores {
  class VerilatorClockedDesign : public VerilatorDesign, public ClockedDesign {
  public:
    virtual ~VerilatorClockedDesign() = default;
  };
}