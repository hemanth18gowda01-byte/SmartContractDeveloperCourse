# Script
Script ran successfully.

== Logs ==
  FundMe deployed to:  0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512

## Setting up 1 EVM.

==========================

Chain 31337

Estimated gas price: 2.000000001 gwei

Estimated total gas used for script: 1646359

Estimated amount required: 0.003292718001646359 ETH

==========================

##### anvil-hardhat
✅  [Success] Hash: 0x91718ec58eefff1aab7635cee03443e6fedbf92323d50bd71b68a1eebfd70ba8
Contract: ETHPriceConverter
Contract Address: 0x5FbDB2315678afecb367f032d93F642f64180aa3
Block: 1
Paid: 0.000367332000367332 ETH (367332 gas * 1.000000001 gwei)


##### anvil-hardhat
✅  [Success] Hash: 0x9a86963311717e3fa9c653682e48cea17105246c14df30fea1fa66c9fdb064b2
Contract: FundMe
Contract Address: 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512
Block: 2
Paid: 0.000789463857847999 ETH (899099 gas * 0.878061101 gwei)

✅ Sequence #1 on anvil-hardhat | Total Paid: 0.001156795858215331 ETH (1266431 gas * avg 0.939030551 gwei)
                                                                                                                               

==========================

ONCHAIN EXECUTION COMPLETE & SUCCESSFUL.

# vm cheat codes
Foundry provides similar helpers for other data types:
• vm.envUint("PRIVATE_KEY") — reads a uint256 (commonly used for private keys).
• vm.envString("RPC_URL") — reads a string.
• vm.envBool("IS_MAINNET") — reads a bool (true / false).
• vm.envOr("VAR_NAME", defaultValue) — reads a variable, or falls back to defaultValue instead of reverting if it's missing.