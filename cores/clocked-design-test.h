#pragma once

#include "design-test.h"

namespace cores {
  template <class Design>
  class ClockedDesignTest : public DesignTest<Design> {
  public:
    virtual ~ClockedDesignTest() = default;

  protected:
    virtual void SetUp() {
      this->dut.Reset();
    }
  };
}