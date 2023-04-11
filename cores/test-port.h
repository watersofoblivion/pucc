#include <cstdint>

#include <gtest/gtest.h>

#include "port.h"

#pragma once

namespace cores {
  class TestPort : public Port {
    bool state;

  public:
    virtual void Set(const bool) final;
    virtual bool Get() final;
  };
}