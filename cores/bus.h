#pragma once

#import "port.h"

namespace cores {
  template <typename WIDTH>
  class Bus : public Port {
  public:
    virtual ~Bus() = default;
  };
}