//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script,console} from "forge-std/Script.sol";
import {FundMe} from "../src/Day_11/FundMe.sol";

contract FundFundMe is Script{
    uint256 public constant SEND_VALUE = 0.01 ether;
    function run() external{
        address fundMeAddress= 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512;
        FundMe fundMe = FundMe(payable(fundMeAddress));
        vm.startBroadcast();
        fundMe.fund{value:SEND_VALUE}();
        console.log("Sent ETH : ",SEND_VALUE);
        vm.stopBroadcast();
    }
}