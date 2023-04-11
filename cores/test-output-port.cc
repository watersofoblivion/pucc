#include <cstdint>

#include <gtest/gtest.h>

#include "output-port.h"

#include "test-output-port.h"

namespace cores {
  void TestOutputPort::Set(const int state) {
    this->state = state;
  }

  int TestOutputPort::Get() {
    return state;
  }
}