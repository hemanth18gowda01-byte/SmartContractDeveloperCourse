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
contract Subscription{
    error AddressAlreadyRegistered_OR_NoAddressFound();
    error SubscriptionExpired();

    bytes32 public expiryDuration;
    constructor(){
        expiryDuration=bytes(uint256(1 weeks));
    }

    struct Subscriber{
        address userAddress;
        bool currentStatus;
        bytes32 timeStamp;
        bytes32 expiryTime;
    }
    address[] public subscribers;
    mapping(address=>Subscriber) public mappedToSubDetails;

    function subscribe() public virtual {
        for (uint i=0;i<subscribers.length;i++){
            if(msg.sender!=address(0)&&msg.sender!=subscribers[i]){
                subscribers.push(msg.sender);
                mappedToSubDetails[msg.sender]=Subsciber({userAddress:msg.sender;currentStatus:true;timeStamp:block.timestamp;expiryTime:block.timestamp+expiryDuration});
            }
            else{
                revert AddressAlreadyRegistered_OR_NoAddressFound();
            }
        }
    }
    function isActive(address _address) public view returns(bool){
        for (uint i=0;i<subscribers.length;i++){
            if(msg.sender==subscribers[i]){
                return mappedToSubDetails[msg.sender].currentStatus;
            }
            else{
                revert AddressAlreadyRegistered_OR_NoAddressFound();
            }
        }

    }
    function getExpiry(address _address) public view returns(bytes32){
        bytes32 remainingTime=(mappedToSubDetails[msg.sender].timeStamp+expiryDuration)-block.timestamp;
        if(remainingTime>=bytes(0)){
            return remainingTime;
        }
        else{
            revert SubscriptionExpired();
        }
    }
}