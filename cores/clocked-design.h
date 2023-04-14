#pragma once

#include "design.h"

namespace cores {
  class ClockedDesign : public Design {
  public:
    virtual ~ClockedDesign() = default;

    virtual void Tick();
    virtual void Tick(const int);

    virtual void ResetStart() = 0;
    virtual void ResetComplete() = 0;
    virtual void Reset();
    virtual void Reset(const int);
  
  protected:
    virtual void Eval() = 0;
    virtual void ToggleClock() = 0;
  };
}