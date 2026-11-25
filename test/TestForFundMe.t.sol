//SPDX-License-Identifier:MIT
pragma solidity ^0.8.35;
/*1. Problem statement
Take your Day 14 FundMe.sol implementation and create a Foundry test suite that verifies its functionality and catches incorrect behavior.

Your goal is to test the contract as if you were reviewing someone else's smart contract.
2. Functional requirements
Create FundMeTest.t.sol.

A. Test setup

Inside setUp():
- Deploy a mock Chainlink price feed.
- Configure a realistic ETH/USD price.
- Deploy your FundMe contract using the mock address.
- Prepare multiple test addresses with ETH balances.
B. Funding tests

Write tests to verify:
Test	Expected behavior
Valid contribution	Transaction succeeds
Below minimum	Reverts
Zero contribution	Reverts
Multiple funders	Correct accounting
Contract balance	Matches deposited ETH

C. Withdrawal tests
- Owner can withdraw.
- Non-owner cannot withdraw.
- Contract balance becomes zero after successful withdrawal.
- Contributor accounting resets.
- Withdrawal works with multiple funders.
D. Oracle tests
- Valid positive price is accepted.
- Negative price is rejected.
- Stale price is rejected.
- Incorrect price-feed decimals are handled correctly.
3. Foundry tools you must use
Cheatcode	Purpose
vm.prank()	Simulate another caller
vm.startPrank()	Simulate multiple calls from one caller
vm.deal()	Give ETH to an address
vm.expectRevert()	Verify expected failures
vm.warp()	Simulate time passing
assertEq()	Verify expected values

Also use makeAddr() to create test addresses.*/

import {Test} from "forge-std/Test.sol";
import {FundMe} from "../Day_11/FundMe.sol";

contract TestForFundMe is Test {
    FundMe public fundMe;

    function fund() public payable {}
    function setUp() public {}
    function withdraw() public {}
    function getConversionRate() public {}
}
