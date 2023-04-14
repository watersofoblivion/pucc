#pragma once

#include <cstdint>

#include <gtest/gtest.h>

#include "input-bus.h"

namespace cores {
  class TestInputBus : public InputBus<int> {
    int actual;

  public:
    virtual ~TestInputBus() = default;

    virtual void Set(const int) final;
    
    void Expect(const int);
  };
}