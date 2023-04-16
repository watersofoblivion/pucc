#pragma once

#include "cores/cores.h"

#include "verilator-design.h"

namespace cores {
  template <class DESIGN>
  class VerilatorCombinatorialDesign : public VerilatorDesign<DESIGN>, public CombinatorialDesign {
  public:
    VerilatorCombinatorialDesign(DESIGN& design) : VerilatorDesign<DESIGN>(design) {}
    virtual ~VerilatorCombinatorialDesign() = default;

    void Eval() final {
      this->design.eval();
    }

    void Finalize() final {
      this->design.final();
    }
  };
}