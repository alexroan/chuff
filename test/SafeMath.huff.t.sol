// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "../src/interfaces/IBasicCalculator.sol";
import "../src/reference/SolidityBasicCalculator.sol";

contract SafeMathTestBase is Test {
    IBasicCalculator internal s_huff;
    IBasicCalculator internal s_solidity;

    uint256 internal constant ONE = 1;
    uint256 internal constant TWO = 2;
    uint256 internal constant FOUR = 4;
    uint256 internal constant MAX = type(uint256).max;
    uint256 internal constant ZERO = 0;

    function setUp() public {
        s_huff = IBasicCalculator(HuffDeployer.config().deploy("examples/BasicCalculator"));
        s_solidity = new SolidityBasicCalculator();
    }
}

contract SafeMathTest__div is SafeMathTestBase {
    function testDivGasHuff() public {
        uint256 result = s_huff.div(FOUR, TWO);
    }

    function testDivGasSolidity() public {
        uint256 result = s_solidity.div(FOUR, TWO);
    }

    function testDivFuzz(uint256 a, uint256 b) public {
        vm.assume(a > 0 && b > 0);
        uint256 divResult;
        uint256 mulCheckResult;
        unchecked {
            divResult = a / b;
            mulCheckResult = divResult * b;
        }
        vm.assume(mulCheckResult == a);
        assertEq(s_huff.div(a, b), divResult);
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

    function testSubFuzz(uint256 a, uint256 b) public {
        vm.assume(a >= b);
        assertEq(s_huff.sub(a, b), a - b);
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

    function testMulFuzz(uint256 a, uint256 b) public {
        vm.assume(a > 0 && b > 0);
        uint256 multiplyResult;
        uint256 divCheckResult;
        unchecked {
            multiplyResult = a * b;
            divCheckResult = multiplyResult / b;
        }
        vm.assume(divCheckResult == a);
        assertEq(s_huff.mul(a, b), multiplyResult);
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

    function testAddFuzz(uint256 a, uint256 b) public {
        uint256 result;
        unchecked {
            result = a + b;
        }
        vm.assume(result >= a && result >= b);
        assertEq(s_huff.add(a, b), result);
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

contract SafeMathTest__mod is SafeMathTestBase {
    function testModGasHuff() public {
        uint256 result = s_huff.mod(MAX, FOUR);
    }

    function testModGasSolidity() public {
        uint256 result = s_solidity.mod(MAX, FOUR);
    }

    function testModFuzz(uint256 a, uint256 b) public {
        vm.assume(b > 0);
        assertEq(s_huff.mod(a, b), a % b);
    }

    function testModSuccess() public {
        assertEq(s_huff.mod(FOUR, TWO), ZERO);
    }

    function testModZeroBReverts() public {
        vm.expectRevert();
        s_huff.mod(FOUR, ZERO);
    }
}
