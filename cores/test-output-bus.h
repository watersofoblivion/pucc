#pragma once

#include <cstdint>

#include <gtest/gtest.h>

#include "output-bus.h"

namespace cores {
  class TestOutputBus : public OutputBus<int> {
    int actual;

  public:
    virtual ~TestOutputBus() = default;

    virtual void Expect(const int) final;
    virtual void Assert(const int) final;

    void Set(const int);
  };
}