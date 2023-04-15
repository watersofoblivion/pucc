#pragma once

#include "cores/cores.h"

namespace cores {
  template <class DESIGN>
  class VerilatorDesign : public Design {
  public:
    VerilatorDesign(DESIGN& design) : design{design} {} 
    virtual ~VerilatorDesign() = default;
  
  protected:
    DESIGN& design;
  };
}