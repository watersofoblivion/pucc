#pragma once

#include "design.h"

namespace cores {
  class CombinatorialDesign : public Design {
  public:
    virtual ~CombinatorialDesign() = default;

    virtual void Eval() = 0;
  };
}