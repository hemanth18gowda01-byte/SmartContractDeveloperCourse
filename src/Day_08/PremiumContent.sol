//SPDX-License-Identifier:MIT
pragma solidity ^0.8.35;
/*3. PremiumContent.sol
Create a separate contract that interacts with SubscriptionManager through the interface.

Implement:
- Constructor accepting the subscription contract address.
- Store the interface reference as immutable.
- getPremiumContent() that checks the caller's subscription before returning content.
- Reject access for inactive subscribers.*/