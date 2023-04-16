#pragma once

#include "design-test.h"

namespace cores {
  template <class DESIGN>
  class ClockedDesignTest : public DesignTest<DESIGN> {
  public:
    virtual ~ClockedDesignTest() = default;

  protected:
    virtual void SetUp() {
      this->dut.Reset();
    }
  };
}