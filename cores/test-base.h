#include <gtest/gtest.h>

#pragma once

namespace cores {
  template <class Dut>
  class TestBase : public ::testing::Test {

  protected:
    std::unique_ptr<Dut> dut;

    void SetUp() final {
      dut = SetUpImpl();
    }

    void TearDown() final {
      TearDownImpl(dut);
    }

    virtual Dut& SetUpImpl() = 0;
    virtual void TearDownImpl(Dut& dut) = 0;
  };
}