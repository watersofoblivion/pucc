#include <memory>

#include <gtest/gtest.h>
#include <verilated.h>

#include "VGateXorTop.h"

#ifndef HDUB_CORE_THRU_WIRE_TEST
#define HDUB_CORE_THRU_WIRE_TEST

namespace hdub::core::logic::gate {
    class GateXorTest : public ::testing::Test {
    protected:
        std::unique_ptr<VGateXorTop> model;

        void SetUp() override;
        void TearDown() override;
    };
}

#endif // HDUB_CORE_THRU_WIRE_TEST