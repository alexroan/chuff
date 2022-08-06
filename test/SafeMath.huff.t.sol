// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "../src/interfaces/ISafeMath.sol";
import "../src/SolidityMath.sol";

contract SafeMathTestBase is Test {
    ISafeMath internal s_huff;
    ISafeMath internal s_solidity;

    uint256 internal constant ONE = 1;
    uint256 internal constant TWO = 2;
    uint256 internal constant FOUR = 4;
    uint256 internal constant MAX = type(uint256).max;
    uint256 internal constant ZERO = 0;

    function setUp() public {
        s_huff = ISafeMath(HuffDeployer.config().deploy("SafeMath"));
        s_solidity = new SolidityMath();
    }
}

contract SafeMathTest__div is SafeMathTestBase {
    function testDivGasHuff() public {
        uint256 result = s_huff.div(FOUR, TWO);
    }

    function testDivGasSolidity() public {
        uint256 result = s_solidity.div(FOUR, TWO);
    }

    function testDivSuccess() public {
        assertEq(s_huff.div(FOUR, TWO), FOUR / TWO);
    }

    function testDivZeroAReverts() public {
        vm.expectRevert();
        s_huff.div(ZERO, TWO);
    }

    function testDivZeroBReverts() public {
        vm.expectRevert();
        s_huff.div(FOUR, ZERO);
    }

    function testDivUnderflowReverts() public {
        vm.expectRevert();
        s_huff.div(ONE, MAX);
    }
}

contract SafeMathTest__sub is SafeMathTestBase {
    function testSubGasHuff() public {
        uint256 result = s_huff.sub(FOUR, TWO);
    }

    function testSubGasSolidity() public {
        uint256 result = s_solidity.sub(FOUR, TWO);
    }

    function testSubSuccess() public {
        assertEq(s_huff.sub(TWO, ONE), (TWO - ONE));
    }

    function testSubUnderflowMINAReverts() public {
        vm.expectRevert();
        s_huff.sub(ZERO, TWO);
    }

    function testSubUnderflowBMAXReverts() public {
        vm.expectRevert();
        s_huff.sub(ONE, MAX);
    }
}

contract SafeMathTest__mul is SafeMathTestBase {
    function testMulGasHuff() public {
        uint256 result = s_huff.mul(FOUR, TWO);
    }

    function testMulGasSolidity() public {
        uint256 result = s_solidity.mul(FOUR, TWO);
    }

    function testMulSuccess() public {
        assertEq(s_huff.mul(TWO, ONE), (TWO * ONE));
    }

    function testMulZeroAReverts() public {
        vm.expectRevert();
        s_huff.mul(ZERO, ONE);
    }

    function testMulZeroBReverts() public {
        vm.expectRevert();
        s_huff.mul(TWO, ZERO);
    }

    function testMulOverflowReverts() public {
        vm.expectRevert();
        s_huff.mul(MAX, MAX);
    }
}

contract SafeMathTest__add is SafeMathTestBase {
    function testAddGasHuff() public {
        uint256 result = s_huff.add(FOUR, TWO);
    }

    function testAddGasSolidity() public {
        uint256 result = s_solidity.add(FOUR, TWO);
    }

    function testAddSuccess() public {
        assertEq(s_huff.add(TWO, ONE), (TWO + ONE));
    }

    function testAddOverflowMAXBReverts() public {
        vm.expectRevert();
        s_huff.add(MAX, ONE);
    }

    function testAddOverflowAMAXReverts() public {
        vm.expectRevert();
        s_huff.add(TWO, MAX);
    }
}
