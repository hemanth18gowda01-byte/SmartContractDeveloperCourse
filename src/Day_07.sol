//SPDX-License-Identifier:MIT
pragma solidity ^0.8.35;

/*Problem statement
Build a UsernameRegistry smart contract where each wallet can register a unique username.

The registry should accept usernames such as:
- mochi_18
- solidity_dev
- blockchain123
Only lowercase English letters, digits, and underscores are allowed.
Functional requirements
Implement these four functions:
Function	Responsibility
registerUsername()	Register a username for msg.sender
getMyUsername()	Return the caller's registered username
isUsernameAvailable()	Check whether a username is available
validateUsername()	Check whether a username meets the rules
*/
contract UsernameRegistry {
    struct Registry {
        string userName;
        address addressOfUser;
    }

    mapping(address => Registry) public addressToRegistry;

    function registerUsername(string memory _userName) public {
        addressToRegistry[msg.sender] = Registry({username: _userName, addressOfUser: msg.sender});
    }

    function getMyUsername() public view returns (Registry) {
        return addressToRegistry[msg.sender];
    }
    function isUsernameAvailable() public {}
    function validateUsername() public {}
}

/*Constraints
1. Username length must be between 3 and 16 bytes.
2. A wallet can register only once.
3. Two wallets cannot register the same username.
4. Use string to store usernames.
5. Use bytes to inspect individual characters.
6. Use keccak256 to compare username hashes.
7. Do not use external libraries.
*/