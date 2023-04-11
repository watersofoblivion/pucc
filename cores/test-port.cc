#include <cstdint>

#include <gtest/gtest.h>

#include "port.h"

#include "test-port.h"

namespace cores {
  void TestPort::Set(const bool state) {
    this->state = state;
  }

  bool TestPort::Get() {
    return this->state;
  }
}