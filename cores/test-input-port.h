#include <cstdint>

#include <gtest/gtest.h>

#include "port.h"

#pragma once

namespace cores {
  class TestInputPort : public InputPort<int> {
    int state;

  public:
    virtual void Set(const int state) final;
    int Get();
  };
}