//SPDX-License-Identifier:MIT
pragma solidity ^0.8.35;
/*1. SubscriptionManager.sol
Create a contract that manages user subscriptions.

Implement:
Function	Responsibility
subscribe()	Activate or extend the caller's subscription
isActive(address)	Check whether a user's subscription is active
getExpiry(address)	Return the user's expiry timestamp

Requirements:
- Store expiry timestamps in a mapping.
- Set subscription duration through the constructor.
- Use block.timestamp to calculate expiry.
- If a user renews before expiry, extend from the existing expiry rather than losing the remaining time.
- If already expired, calculate the new expiry from the current timestamp.*/