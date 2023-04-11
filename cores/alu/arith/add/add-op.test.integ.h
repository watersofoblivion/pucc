#include <cstdint>

#include <gtest/gtest.h>
// #include <verilated.h>

#include "test-base.h"

#pragma once

namespace cores::alu::arith::add {
  class AddOp {
  public:
    virtual void Lhs(const int32_t) = 0;
    virtual void Rhs(const int32_t) = 0;
    virtual const int32_t Res() = 0;
  };

  class AddOpIntegTest : public TestBase<AddOp> {
    protected:

      void SetUp();
      void TearDown();
  };
}
