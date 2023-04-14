#pragma once

#include <cstdint>

#include "output.h"
#include "bus.h"

namespace cores {
  template <typename WIDTH>
  class OutputBus : public Output, public Bus<WIDTH> {
  public:
    virtual ~OutputBus() = default;

    virtual void Expect(const WIDTH) = 0;
    virtual void Assert(const WIDTH) = 0;
  };
}