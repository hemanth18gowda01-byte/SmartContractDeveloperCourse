//SPDX-License-Identifier:MIT
pragma solidity ^0.8.35;
/*Build: VaultTest.t.sol

Create a simple ETH vault with:
- deposit()
- withdraw()
- getBalance()
Write tests for:
1. Depositing ETH from multiple users.
2. Rejecting zero deposits.
3. Preventing withdrawals exceeding the user's balance.
4. Ensuring one user cannot withdraw another user's ETH.
5. Checking balances after multiple deposits and withdrawals.
Foundry tools:
- vm.prank()
- vm.deal()
- vm.expectRevert()
- assertEq()*/
import {Test, console} from "forge-std/Test.sol";
import {Vault} from "../src/vault.sol";

contract VaultTest is Test{}