#pragma once

#include "input-signal.h"

namespace cores {
  class TestInputSignal : public InputSignal {
    bool actual;

  public:
    virtual ~TestInputSignal() = default;

    virtual void Set(const bool) final;

    void Expect(const bool);
  };
}