#include "thru-wire-integration-test.h"

#include <memory>

#include <gtest/gtest.h>
#include <gmock/gmock.h>
#include <verilated.h>

#include "VIntegrationTestTop.h"

using ::testing::Eq;

namespace hdub::core {
    void ThruWireIntegrationTest::SetUp() {
        model = std::unique_ptr<VIntegrationTestTop>(new VIntegrationTestTop("IntegrationTestTop"));
    }

    void ThruWireIntegrationTest::TearDown() {
        model->final();
    }

    TEST_F(ThruWireIntegrationTest, Zero) {
        model->in = 0;
        model->eval();

        EXPECT_THAT(model->out, Eq(0));
    }

    TEST_F(ThruWireIntegrationTest, One) {
        model->in = 1;
        model->eval();

        EXPECT_THAT(model->out, Eq(1));
    }
}