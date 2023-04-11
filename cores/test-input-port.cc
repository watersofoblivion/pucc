#include <cstdint>

#include <gtest/gtest.h>

#include "input-port.h"

#include "test-input-port.h"

namespace cores {
  void TestInputPort::Set(const int state) {
    this->state = state;
  };

  int TestInputPort::Get() {
    return state;
  }
}