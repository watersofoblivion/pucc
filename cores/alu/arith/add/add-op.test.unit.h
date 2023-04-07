#include <cstdint>

#include <gtest/gtest.h>
// #include <verilated.h>

#ifndef CORES_ALU_ARITH_ADD_UNIT_TEST
#define CORES_ALU_ARITH_ADD_UNIT_TEST

namespace cores::alu::arith::add {
  class AddOp {
  public:
    virtual void Lhs(const int32_t) = 0;
    virtual void Rhs(const int32_t) = 0;
    virtual const int32_t Res() = 0;
  };

  class AddOpUnitTest : public ::testing::Test {
    protected:

      void SetUp();
      void TearDown();
  };
}

#endif // CORES_ALU_ARITH_ADD_UNIT_TEST