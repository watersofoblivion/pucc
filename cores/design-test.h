#pragma once

#include <gtest/gtest.h>

namespace cores {
  template <class DESIGN>
  class DesignTest : public ::testing::Test {
  public:
    virtual ~DesignTest() = default;

  protected:
    DESIGN& dut;
  };
}