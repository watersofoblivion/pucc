#include "gate-factory-test.h"

#include <memory>
#include <iostream>

#include <gtest/gtest.h>
#include <gmock/gmock.h>
#include <verilated.h>

#include "VGateFactoryTop.h"

using ::testing::Eq;

namespace hdub::core::logic::gate {
    void GateFactoryTest::SetUp() {
        model = std::unique_ptr<VGateFactoryTop>(new VGateFactoryTop("Top"));
    }

    void GateFactoryTest::TearDown() {
        model->final();
    }

    TEST_F(GateFactoryTest, ZeroZero) {
        model->lhs = 0;
        model->rhs = 0;
        model->operand = 0;

        model->eval();

        EXPECT_THAT(model->and_result, Eq(0));
        EXPECT_THAT(model->or_result, Eq(0));
        EXPECT_THAT(model->xor_result, Eq(0));
        EXPECT_THAT(model->not_result, Eq(1));
    }

    TEST_F(GateFactoryTest, ZeroOne) {
        model->lhs = 0;
        model->rhs = 1;
        model->operand = 0;

        model->eval();

        EXPECT_THAT(model->and_result, Eq(0));
        EXPECT_THAT(model->or_result, Eq(1));
        EXPECT_THAT(model->xor_result, Eq(1));
        EXPECT_THAT(model->not_result, Eq(1));
    }

    TEST_F(GateFactoryTest, OneZero) {
        model->lhs = 1;
        model->rhs = 0;
        model->operand = 1;

        model->eval();

        EXPECT_THAT(model->and_result, Eq(0));
        EXPECT_THAT(model->or_result, Eq(1));
        EXPECT_THAT(model->xor_result, Eq(1));
        EXPECT_THAT(model->not_result, Eq(0));
    }

    TEST_F(GateFactoryTest, OneOne) {
        model->lhs = 1;
        model->rhs = 1;
        model->operand = 1;

        model->eval();

        EXPECT_THAT(model->and_result, Eq(1));
        EXPECT_THAT(model->or_result, Eq(1));
        EXPECT_THAT(model->xor_result, Eq(0));
        EXPECT_THAT(model->not_result, Eq(0));
    }
}