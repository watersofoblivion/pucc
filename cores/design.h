#pragma once

namespace cores {
  class Design {
  public:
    virtual ~Design() = default;
    virtual void Eval() = 0;
    virtual void Finalize() = 0;
  };
}