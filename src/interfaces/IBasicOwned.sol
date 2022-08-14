// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

interface IBasicOwned {
    function restricted() external returns (uint256);

    function open() external returns (uint256);

    function owner() external returns (address);
}
