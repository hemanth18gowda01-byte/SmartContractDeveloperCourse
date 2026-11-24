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

    address immutable i_BUYER;
    uint256 public numberOfBuyers;
    /*A. Deposit

Buyer deposits ETH using deposit().

Store the buyer's address and deposited amount.

Only one active escrow at a time.*/

    constructor() {
        i_BUYER = msg.sender;
        numberOfBuyers=0;
    }

    struct BuyerDetails{
        address buyer;
        uint256 depositedAmount;
        bool confirmationStatus;
    }

    mapping(address=>BuyerDetails) public buyerdetails;
    address[] public buyers;

    event confirming(address indexed owner, uint256 amount, bool status);

    modifier onlyBuyer() internal{
        if(msg.sender==i_BUYER){
            _;
        }
        else{
             revert OnlyOwnerCanMakeChanges();
        }
    }

    function deposit() public payable {
        if(msg.value>0){
            buyerdetails[msg.sender]=BuyerDetails({buyer:msg.sender,depositedAmount:msg.value,confimationStatus:false});
            buyers.push(msg.sender);
            numberOfBuyers+=1;
        }
        else{
            revert InsufficientFunds();
        }
    }
    function confirmDelivery() public onlyBuyer {
        for(uint i=0;i<buyers.length;i++){
            if(msg.sender==buyers[i]&&msg.sender==buyerdetails[msg.sender].buyer){
                buyerdetails[msg.sender].confirmationStatus=true;
                break;
            }
            revert NoBuyerFound(); 
        }
        emit confirming(owner=msg.sender,amount=buyerdetails[msg.sender].depositedAmount,status:buyerdetails[msg.sender].confirmationStatus);
    }
    function withdraw() external payable onlyBuyer{
        (bool success,)=recipient.call{value:buyerdetails[msg.sender].depositedAmount}("");
        if (success){
            buyerdetails[msg.sender].buyer=address(0);
            buyerdetails[msg.sender].depositedAmount=0;
            buyerdetails[msg.sender].confirmationStatus=false;
        }
    }
    function refund() public {}
}
