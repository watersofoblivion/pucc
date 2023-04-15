#pragma once

#include "cores/cores.h"
#include "verilator-design.h"

namespace cores {
  class VerilatorCombinatorialDesign : public VerilatorDesign, public CombinatorialDesign {
  public:
    virtual ~VerilatorCombinatorialDesign() = default;
  };
}