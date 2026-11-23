//SPDX-License-Identifier:MIT
pragma solidity ^0.8.35;
/*Challenge
Build a subscription system using two separate smart contracts that communicate through an interface.
System architecture
SubscriptionManager.sol

Stores subscription expiry and checks membership

ISubscriptionManager interface
External view function call

PremiumContent.sol

Checks subscription status before providing access

2. ISubscriptionManager.sol
Create an interface exposing:

- isActive(address user)

Use the correct function visibility and mutability.
*/
interface ISubscription{
    function isActive(address user) external view returns(bool);
}