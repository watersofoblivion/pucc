#pragma once

#import "port.h"

namespace cores {
  class Input : public Port {
  public:
    virtual ~Input() = default;
  };
}