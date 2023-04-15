#pragma once

#include "cores/cores.h"
#include "verilator-design.h"

namespace cores {
  template <class DESIGN>
  class VerilatorClockedDesign : public VerilatorDesign<DESIGN>, public ClockedDesign {
  public:
    VerilatorClockedDesign(DESIGN& design, VerilatorInputSignal& clk) : VerilatorDesign<DESIGN>(design), ClockedDesign(clk) {}
    virtual ~VerilatorClockedDesign() = default;

    void Eval() final {
      this->design.eval();
    }

    void Finalize() final {
      this->design.final();
    }
  };
}