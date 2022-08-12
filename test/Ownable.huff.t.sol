// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "../src/interfaces/IBasicOwned.sol";
import "../src/reference/SolidityBasicOwned.sol";

contract OwnableTestBase is Test {
    IBasicOwned internal s_huff;
    IBasicOwned internal s_solidity;

    address internal constant OWNER = address(999);
    uint256 internal constant RESTRICTED_CONST = 123;
    uint256 internal constant OPEN_CONST = 1;

    function setUp() public {
        changePrank(OWNER);
        s_huff = IBasicOwned(
            HuffDeployer.config().deploy("examples/BasicOwned")
        );
        s_solidity = new SolidityBasicOwned();
    }
}

contract OwnableTest__restricted is OwnableTestBase {
    function testRestrictedSuccess() public {
        changePrank(OWNER);
        assertEq(RESTRICTED_CONST, s_huff.restricted());
    }
}

contract OwnableTest__open is OwnableTestBase {
    function testOpenSuccess() public {
        assertEq(OPEN_CONST, s_huff.open());
    }
}
