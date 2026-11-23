//SPDX-License-Identifier:MIT
pragma solidity ^0.8.35;
/*3. PremiumContent.sol
Create a separate contract that interacts with SubscriptionManager through the interface.

Implement:
- Constructor accepting the subscription contract address.
- Store the interface reference as immutable.
- getPremiumContent() that checks the caller's subscription before returning content.
- Reject access for inactive subscribers.*/
import {ISubscription} from "./ISubscriptionManager.sol";
import {Subscription} from "./SubscriptionManager.sol";

contract PremiumContent {
    ISubscription public immutable subscription;

    constructor(address _subscriptionAddress) {
        subscription = ISubscription(_subscriptionAddress);
    }

    function getPremiumContent() public view returns (string memory) {
        require(subscription.isActive(msg.sender), "Access denied: Inactive subscription");
        return "Welcome to the premium content!";
    }
}
