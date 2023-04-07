#include <memory>

#include <gtest/gtest.h>
#include <verilated.h>

#include "VIntegrationTestTop.h"

#ifndef HDUB_CORE_THRU_WIRE_TEST
#define HDUB_CORE_THRU_WIRE_TEST

namespace cores {
    class ThruWireIntegrationTest : public ::testing::Test {
    protected:
        std::unique_ptr<VIntegrationTestTop> model;

        void SetUp() override;
        void TearDown() override;
    };
}

#endif // HDUB_CORE_THRU_WIRE_TEST