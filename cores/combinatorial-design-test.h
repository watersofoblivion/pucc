#pragma once

#include "design-test.h"

namespace cores {
  template <class Design>
  class CombinatorialDesignTest : public DesignTest<Design> {
  public:
    virtual ~CombinatorialDesignTest() = default;
  };
}