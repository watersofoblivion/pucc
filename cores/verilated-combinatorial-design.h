#pragma once

#include "cores/cores.h"
#include "verilated-design.h"

namespace cores {
  class VerilatedCombinatorialDesign : public VerilatedDesign, public CombinatorialDesign {
  public:
    virtual ~VerilatedCombinatorialDesign() = default;
  };
}