//SPDX-License-Identifier:MIT
pragma solidity ^0.8.24;

/* Build a smart contract that maintains a numerical counter.

Any user should be able to increment or decrement the counter, but only the contract owner should be allowed to reset it.
2. Functional requirements
Function	- Expected behavior
increment()	- Increase counter by 1
decrement()	- Decrease counter by 1
reset()	  - Set counter to zero
getCount()	- Return current count
Constructor	- Set initial owner*/
contract NumericalCounter {
    uint256 public counter;
    address immutable i_OWNER;

    error NotAdmin();

    constructor() {
        i_OWNER = msg.sender;
        counter = 0;
    }

    modifier onlyAdmin() {
        if (msg.sender == i_OWNER) {
            _;
        } else {
            revert NotAdmin();
        }
    }

    function increment() public {
        counter += 1;
    }

    function decrement() public {
        counter -= 1;
    }

    function getCount() public view returns (uint256) {
        return counter;
    }

    function reset() public onlyAdmin {
        counter = 0;
    }
}
