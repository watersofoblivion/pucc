#pragma once

#include "input-signal.h"
#include "design.h"

namespace cores {
  class ClockedDesign : public Design {
  public:
    ClockedDesign(InputSignal& clk) : clk(clk) {}
    virtual ~ClockedDesign() = default;

    virtual void ClockHigh();
    virtual void ClockLow();
    virtual void Tick();
    virtual void Tick(const int);
  
  protected:
    InputSignal& clk;
  };
}