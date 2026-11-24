//SPDX-License-Identifier:MIT
pragma solidity ^0.8.35;
/*1. Problem statement
Create FundMe.sol.

Anyone can fund the contract, but their contribution must meet a minimum USD value. The contract uses Chainlink ETH/USD Price Feeds to calculate the contribution value.

The owner can withdraw all collected ETH.
2. Functional requirements
A. Constructor
- Accept a Chainlink price-feed address.
- Store the deployer as the owner.
- Set a minimum contribution of $5 (USD, represented in the appropriate integer units).
B. Funding

Implement:

fund()
- Must be payable.
- Convert msg.value into USD using Chainlink.
- Reject contributions below the minimum.
- Track how much each address has contributed.
- Maintain an array of funders.
C. Price conversion

Implement:

getConversionRate(uint256 ethAmount)
- Retrieve the latest ETH/USD price.
- Account for feed decimals.
- Return the USD value in a consistent unit.
D. Withdrawal

Implement:

withdraw()
- Only the owner can withdraw.
- Transfer the entire contract balance using call.
- Follow Checks-Effects-Interactions.
- Reset contributor accounting after successful withdrawal.*/

import {PriceConverter} from "../Day_10/ETHPriceConverter.sol";

contract FundMe {
    function fund() public payable {
        // Implementation of funding logic
    }
    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        // Implementation of price conversion logic
    }
    function withdraw() public {
        // Implementation of withdrawal logic
    }
}
