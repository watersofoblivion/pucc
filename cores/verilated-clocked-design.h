#pragma once

#include "cores/cores.h"
#include "verilated-design.h"

namespace cores {
  class VerilatedClockedDesign : public VerilatedDesign, public ClockedDesign {
  public:
    virtual ~VerilatedClockedDesign() = default;
  };
}