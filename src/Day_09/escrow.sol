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
    error InsufficientFunds();
    error NoBuyerFound();
    error refundFailed();

    address immutable i_BUYER;
    uint256 public numberOfBuyers;
    uint256 public i_DURATION;
    address immutable i_SELLER;
    /*A. Deposit

    Buyer deposits ETH using deposit().

    Store the buyer's address and deposited amount.

    Only one active escrow at a time.*/

    constructor(address _seller) {
        i_BUYER = msg.sender;
        i_SELLER = _seller;
        numberOfBuyers = 0;
        i_DURATION = 1 weeks;
    }

    struct BuyerDetails {
        address buyer;
        uint256 depositedAmount;
        bool confirmationStatus;
        uint256 time;
    }

    mapping(address => BuyerDetails) public buyerdetails;
    address[] public buyers;

    event confirming(address indexed owner, uint256 amount, bool status);

    modifier onlyBuyer() {
        if (msg.sender == i_BUYER) {
            _;
        } else {
            revert OnlyOwnerCanMakeChanges();
        }
    }

    function deposit() public payable {
        if (msg.value > 0) {
            buyerdetails[msg.sender] =
                BuyerDetails({
                buyer: msg.sender, depositedAmount: msg.value, confimationStatus: false, time: block.timestamp
            });
            buyers.push(msg.sender);
            numberOfBuyers += 1;
        } else {
            revert InsufficientFunds();
        }
    }

    function confirmDelivery() public onlyBuyer {
        for (uint256 i = 0; i < buyers.length; i++) {
            if (msg.sender == buyers[i] && msg.sender == buyerdetails[msg.sender].buyer) {
                buyerdetails[msg.sender].confirmationStatus = true;
                break;
            }
            revert NoBuyerFound();
        }
        emit confirming(
            msg.sender, buyerdetails[msg.sender].depositedAmount, buyerdetails[msg.sender].confirmationStatus
        );
    }

    function withdraw() external payable onlySeller {
        if (address(this).value > 0) {
            (bool success,) = i_SELLER.call{value: address(this).value}("");
            address(this).balance = 0;
        } else {
            revert InsufficientFunds();
        }
    }

    function refund() public onlyBuyer {
        if (block.timestamp > buyerdetails[msg.sender].time + i_DURATION) {
            (bool success,) = recipient.call{value: buyerdetails[msg.sender].depositedAmount}("");
            if (success) {
                buyerdetails[msg.sender].buyer = address(0);
                buyerdetails[msg.sender].depositedAmount = 0;
                buyerdetails[msg.sender].confirmationStatus = false;
            } else {
                revert refundFailed();
            }
        }
    }
}
