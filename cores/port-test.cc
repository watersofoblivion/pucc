#include <cstdint>

#include <gtest/gtest.h>

#include "port.h"

#include "test-port.h"
#include "port-test.h"

namespace cores {
  void PortTest::SetUp() {
    port = new TestPort();
  }

  void PortTest::TearDown() {
    delete port;
  }
}