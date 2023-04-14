#pragma once

#include <gtest/gtest.h>

namespace cores {
  template <class Design>
  class DesignTest : public ::testing::Test {
  public:
    virtual ~DesignTest() = default;

  protected:
    Design dut;
  };
}