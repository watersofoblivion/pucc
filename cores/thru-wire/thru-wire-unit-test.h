#include <memory>

#include <gtest/gtest.h>
#include <verilated.h>

#include "VUnitTestTop.h"

#ifndef HDUB_CORE_THRU_WIRE_TEST
#define HDUB_CORE_THRU_WIRE_TEST

namespace cores {
    class ThruWireUnitTest : public ::testing::Test {
    protected:
        std::unique_ptr<VUnitTestTop> model;

        void SetUp() override;
        void TearDown() override;
    };
}

#endif // HDUB_CORE_THRU_WIRE_TEST