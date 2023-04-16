#pragma once

#include "output-signal.h"

namespace cores {
  class TestOutputSignal : public OutputSignal {
    bool actual;

  public:
    virtual ~TestOutputSignal() = default;

    virtual void Expect(const bool) final;
    virtual void Assert(const bool) final;

    void Set(const bool);
  };
}