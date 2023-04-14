#include <random>
#include <cstdint>

#include <gtest/gtest.h>

#include "input-signal.h"

#include "test-input-signal.h"

#include "input-signal-test.h"

namespace cores {
  TEST_F(InputSignalTest, Set) {
    signal.Set(true);
    test_signal.Expect(true);

    signal.Set(false);
    test_signal.Expect(false);
  }

  TEST_F(InputSignalTest, SetHigh) {
    signal.SetHigh();
    test_signal.Expect(true);
  }

  TEST_F(InputSignalTest, SetLow) {
    signal.SetLow();
    test_signal.Expect(false);
  }
}
