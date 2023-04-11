#include <cstdint>

#include "port.h"

#pragma once

namespace cores {
  template <typename WIDTH>
  class OutputPort : public Port {
  public:
    virtual ~OutputPort() = default;

    virtual WIDTH Get() = 0;
  };
}