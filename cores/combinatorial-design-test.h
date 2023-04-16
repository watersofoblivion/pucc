#pragma once

#include "design-test.h"

namespace cores {
  template <class DESIGN>
  class CombinatorialDesignTest : public DesignTest<DESIGN> {
  public:
    virtual ~CombinatorialDesignTest() = default;
  };
}