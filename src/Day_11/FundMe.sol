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

import {ETHPriceConverter} from "../Day_10/ETHPriceConverter.sol";

contract FundMe {
    error NotOwner();
    error LessThanMinimum();
    error FundTransferFailed();
    error NoFundsToWithdraw();

    uint256 public constant MINIMUM_USD = 2 * 10 ** 18; // Minimum contribution in USD (scaled to 18 decimals)
    address immutable i_OWNER;
    ETHPriceConverter private immutable i_priceConverter;

    constructor(address priceFeedAddress) {
        i_OWNER = msg.sender;
        i_priceConverter = new ETHPriceConverter(priceFeedAddress);
    }

    modifier onlyowner() {
        if (msg.sender != i_OWNER) {
            revert NotOwner();
        }
        _;
    }

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable {
        if (msg.value >= MINIMUM_USD) {
            (bool sent,) = payable(msg.sender).call{value: msg.value}("");
            if (sent) {
                for (uint256 i = 0; i < funders.length; i++) {
                    if (msg.sender == funders[i]) {
                        addressToAmountFunded[msg.sender] += msg.value;
                    } else {
                        funders.push(msg.sender);
                        addressToAmountFunded[msg.sender] += msg.value;
                    }
                }
            } else {
                revert FundTransferFailed();
            }
        } else {
            revert LessThanMinimum();
        }
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        return uint256(i_priceConverter.getConversionRate(ethAmount));
    }

    function withdraw() public onlyowner {
        if (address(this).balance != 0) {
            (bool sent,) = payable(i_OWNER).call{value: address(this).balance}("");
            if (!sent) {
                revert FundTransferFailed();
            }
        } else {
            revert NoFundsToWithdraw();
        }
    }
}
