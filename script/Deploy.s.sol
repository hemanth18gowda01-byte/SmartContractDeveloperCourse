//SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;
/*1. Problem statement
Build a deployment and interaction workflow for your existing FundMe contract using Foundry scripts.

Your workflow must automatically:
1. Deploy a mock Chainlink price feed.
2. Deploy the FundMe contract using the mock address.
3. Allow a user to interact with the deployed contract through another script.
4. Display the deployed contract address and transaction information.
2. Functional requirements
A. Deployment script — DeployFundMe.s.sol

Create a script that:
- Inherits from Foundry's Script.
- Deploys your mock price feed.
- Initializes the mock with an ETH/USD price.
- Deploys FundMe using the mock address.
- Returns or exposes the deployed contract address.
B. Interaction script — FundFundMe.s.sol

Create a separate script that:
- Reads the deployed FundMe address from an environment variable.
- Calls fund() with an ETH contribution.
- Uses vm.startBroadcast() and vm.stopBroadcast() appropriately.
- Displays the contribution and target contract address.
C. Deployment verification

After deployment, verify:
- The FundMe contract has the expected owner.
- The price-feed address is correctly configured.
- The deployed contract has the expected initial balance.*/

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/Day_11/FundMe.sol";
import {ETHPriceConverter} from "../src/Day_10/ETHPriceConverter.sol";
import {console} from "forge-std/console.sol";

contract DeployFundMe is Script{
    function run() external{
        vm.startBroadcast();
        ETHPriceConverter ethPriceConverter = new ETHPriceConverter(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        FundMe fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        vm.stopBroadcast();
        console.log("FundMe deployed to: ", address(fundMe));
    }
}