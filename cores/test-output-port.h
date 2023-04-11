#include <cstdint>

#include <gtest/gtest.h>

#include "output-port.h"

#pragma once

namespace cores {
  class TestOutputPort : public OutputPort<int> {
    int state;

  public:
    virtual int Get() final;

    void Set(const int);
  };
}