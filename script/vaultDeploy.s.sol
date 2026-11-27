//SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

import {Script, console} from "forge-std/Script.sol";
import {Vault} from "../src/vault.sol";

contract VaultDeploy is Script {
    function run() external {
        vm.startBroadcast();
        Vault vault = new Vault();
        vm.stopBroadcast();
        console.log("Vault deployed to: ", address(vault));
    }
}