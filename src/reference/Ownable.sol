// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract Ownable {
    address internal s_owner;

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        s_owner = msg.sender;
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return s_owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == msg.sender, "Ownable: caller is not the owner");
        _;
    }
}
