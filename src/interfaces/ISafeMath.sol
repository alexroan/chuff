// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

interface ISafeMath {
    function add(uint256, uint256) external returns (uint256);

    function mul(uint256, uint256) external returns (uint256);

    function sub(uint256, uint256) external returns (uint256);

    function div(uint256, uint256) external returns (uint256);
}
