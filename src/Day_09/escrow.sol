//SPDX-License-Identifier:MIT
pragma solidity ^0.8.35;
/*i have already done this
Ayyy, my bad Mochi! 😂❤️ No repeating completed exercises.

Let's skip RBAC and move forward to a new challenge.

Day 12 — ETH Escrow & Secure Withdrawals
Intermediate+
30–40 minutes
ETH security
Problem: Build an escrow contract where a buyer deposits ETH, an administrator confirms delivery, and the seller withdraws the funds.

1. Functional requirements
Create Escrow.sol.

A. Deposit

Buyer deposits ETH using deposit().

Store the buyer's address and deposited amount.

Only one active escrow at a time.

B. Confirm delivery

Only the buyer can call confirmDelivery().

Mark the escrow as approved for withdrawal.

Emit a DeliveryConfirmed event.

C. Withdraw

Only the seller can withdraw.

Transfer ETH using low-level call.

Prevent multiple withdrawals.

Follow Checks-Effects-Interactions.

D. Refund

Allow the buyer to reclaim ETH if delivery hasn't been confirmed and the escrow has expired.

Use block.timestamp for expiry.*/

contract Escrow {
    error OnlyOwnerCanMakeChanges();

    address immutable i_OWNER;

    constructor() {
        i_OWNER = msg.sender;
    }

    event confirming(address indexed owner, uint256 amount, bool status);

    function deposit() public payable {}
    function confirmDelivery() public {}
    function withdraw() external {}
    function refund() public {}
}
