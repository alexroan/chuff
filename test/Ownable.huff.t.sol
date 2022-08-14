// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "../src/interfaces/IBasicOwned.sol";
import "../src/reference/SolidityBasicOwned.sol";

contract OwnableTestBase is Test {
    IBasicOwned internal s_huff;
    IBasicOwned internal s_solidity;

    HuffConfig internal s_config;
    // These are both in storage instead of constants because HuffDeployer
    // doesn't support pranks when deploying, the `msg.sender` is always the
    // HuffConfig. To ensure gas comparisons are fair, we use storage for both
    // the Solidity and Huff owners.
    address internal s_huffOwner;
    address internal s_solidityOwner;

    address internal constant OWNER = address(1);
    address internal constant STRANGER = address(99);
    uint256 internal constant RESTRICTED_CONST = 123;
    uint256 internal constant OPEN_CONST = 1;

    function setUp() public {
        s_config = HuffDeployer.config();
        s_huffOwner = address(s_config);
        s_huff = IBasicOwned(s_config.deploy("examples/BasicOwned"));

        changePrank(s_solidityOwner);
        s_solidity = new SolidityBasicOwned();
    }
}

contract OwnableTest__restricted is OwnableTestBase {
    function testRestrictedSuccess() public {
        changePrank(s_huffOwner);
        assertEq(RESTRICTED_CONST, s_huff.restricted());
    }

    function testRestrictedGasHuff() public {
        changePrank(s_huffOwner);
        uint256 result = s_huff.restricted();
    }

    function testRestrictedGasSolidity() public {
        changePrank(s_solidityOwner);
        uint256 result = s_solidity.restricted();
    }

    function testRestrictedNonOwnerReverts() public {
        changePrank(STRANGER);
        vm.expectRevert();
        uint256 result = s_huff.restricted();
    }
}

contract OwnableTest__open is OwnableTestBase {
    function testOpenStrangerSuccess() public {
        changePrank(STRANGER);
        assertEq(OPEN_CONST, s_huff.open());
    }

    function testOpenOwnerSuccess() public {
        changePrank(s_huffOwner);
        assertEq(OPEN_CONST, s_huff.open());
    }

    function testOpenGasHuff() public {
        uint256 result = s_huff.open();
    }

    function testOpenSolidityHuff() public {
        uint256 result = s_solidity.open();
    }
}
