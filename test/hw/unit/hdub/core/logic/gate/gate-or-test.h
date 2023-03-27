#include <memory>

#include <gtest/gtest.h>
#include <verilated.h>

#include "VGateOrTop.h"

#ifndef HDUB_CORE_THRU_WIRE_TEST
#define HDUB_CORE_THRU_WIRE_TEST

namespace hdub::core::logic::gate {
    class GateOrTest : public ::testing::Test {
    protected:
        std::unique_ptr<VGateOrTop> model;

        void SetUp() override;
        void TearDown() override;
    };
}

#endif // HDUB_CORE_THRU_WIRE_TEST