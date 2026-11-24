//SPDX-License-Identifier:MIT
pragma solidity ^0.8.35;
/*1. Problem statement
Build an ETHPriceConverter contract that retrieves the current ETH/USD price from a Chainlink Price Feed and converts ETH amounts into USD values.
2. Functional requirements
A. Create an interface
Create AggregatorV3Interface.sol.

Declare the following function:

latestRoundData()

It should return:
- Round ID
- Price
- Started timestamp
- Updated timestamp
- Answered-in-round
Also declare:

decimals()
B. Create ETHPriceConverter.sol
Implement these functions:
Function	Responsibility
getLatestPrice()	Fetch ETH/USD price
getETHPriceInUSD()	Return ETH price in USD
getConversionRate(uint256 ethAmount)	Convert ETH amount into USD


C. Oracle validation
Your implementation must:
- Check that the returned price is positive.
- Check that the price feed has been updated recently.
- Account for the oracle's decimal precision.
- Avoid incorrect calculations caused by integer division.
D. Contract configuration
Accept the Chainlink price-feed address through the constructor.

Store the feed reference as immutable.*/

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract ETHPriceConverter {
    AggregatorV3Interface private i_priceFeed;

    constructor(address _priceFeed) {
        i_priceFeed = AggregatorV3Interface(_priceFeed);
    }

    function getLatestPrice() public view returns (int256) {
        // Implementation to fetch the latest ETH/USD price from Chainlink Price Feed
        (, int256 answer,,,) = i_priceFeed.latestRoundData();
        require(answer > 0, "Invalid price");
        return answer;
    }

    function getETHPriceInUSD() public view returns (int256) {
        // Implementation to return ETH price in USD
        return getLatestPrice();
    }

    function getConversionRate(uint256 ethAmount) public view returns (int256) {
        // Implementation to convert ETH amount into USD
        int256 latestPrice = getLatestPrice();
        return (latestPrice * int256(ethAmount)) / 10 ** 18;
    }
}
