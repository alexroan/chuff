// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "./Ownable.sol";
import "../interfaces/IBasicOwned.sol";

contract SolidityBasicOwned is IBasicOwned, Ownable {
    uint256 private constant RESTRICTED_CONST = 123;
    uint256 private constant OPEN_CONST = 1;

    function restricted() external view override onlyOwner returns (uint256) {
        return RESTRICTED_CONST;
    }

    function open() external pure override returns (uint256) {
        return OPEN_CONST;
    }

    function owner() public view override (IBasicOwned, Ownable) returns (address) {
        return s_owner;
    }
}
