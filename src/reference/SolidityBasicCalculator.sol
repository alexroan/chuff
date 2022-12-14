// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "../interfaces/IBasicCalculator.sol";

contract SolidityBasicCalculator is IBasicCalculator {
    function add(uint256 a, uint256 b) external pure override returns (uint256) {
        return a + b;
    }

    function mul(uint256 a, uint256 b) external pure override returns (uint256) {
        return a * b;
    }

    function sub(uint256 a, uint256 b) external pure override returns (uint256) {
        return a - b;
    }

    function div(uint256 a, uint256 b) external pure override returns (uint256) {
        return a / b;
    }

    function mod(uint256 a, uint256 b) external pure override returns (uint256) {
        return a % b;
    }
}
