#include <memory>

#include <gtest/gtest.h>
#include <verilated.h>

#include "VGateFactoryTop.h"

#ifndef HDUB_CORE_THRU_WIRE_TEST
#define HDUB_CORE_THRU_WIRE_TEST

namespace hdub::core::logic::gate {
    class GateFactoryTest : public ::testing::Test {
    protected:
        std::unique_ptr<VGateFactoryTop> model;

        void SetUp() override;
        void TearDown() override;
    };
}

#endif // HDUB_CORE_THRU_WIRE_TEST