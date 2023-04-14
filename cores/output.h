#pragma once

#include "port.h"

namespace cores {
  class Output : public Port {
  public:
    virtual ~Output() = default;
  };
}