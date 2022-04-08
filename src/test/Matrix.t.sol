// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { DSTest } from "ds-test/test.sol";
import { DSTestPlus } from "./DSTestPlus.sol";

import { Matrix } from "../Matrix.sol";

contract MatrixMock {
    function from(uint256 m, uint256 n) public pure returns (int256[][] memory) {
        return Matrix.from(m, n);
    }
}

contract MatrixTest is DSTest, DSTestPlus {
    using Matrix for int256[][];

    function setUp() public {}

    function testFrom() public {
        int256[][] memory A = Matrix.from(3, 4);

        assertEq(A.length, 3);
        assertEq(A[0].length, 4);
        assertEq(A[1].length, 4);
        assertEq(A[2].length, 4);

        for (uint256 i = 0; i < 3; i++) {
            for (uint256 j = 0; j < 4; j++) {
                assertEq(A[i][j], 0);
            }
        }
    }

    function testShape() public {
        int256[][] memory A = Matrix.from(3, 4);

        (uint256 m, uint256 n) = A.shape();
        assertEq(m, 3);
        assertEq(n, 4);
    }

    function testSize() public {
        int256[][] memory A = Matrix.from(3, 4);

        assertEq(A.size(), 3 * 4);
    }

    function testT() public {
        int256[][] memory A = Matrix.from(3, 2);

        A[0][0] = 1;
        A[0][1] = 2;
        A[1][0] = 3;
        A[1][1] = 4;
        A[2][0] = 5;
        A[2][1] = 6;

        int256[][] memory X = A.T();

        assertEq(X[0][0], 1);
        assertEq(X[0][1], 3);
        assertEq(X[0][2], 5);
        assertEq(X[1][0], 2);
        assertEq(X[1][1], 4);
        assertEq(X[1][2], 6);
    }

    function testFill() public {
        int256[][] memory A = Matrix.fill(3, 4, 69);

        for (uint256 i = 0; i < 3; i++) {
            for (uint256 j = 0; j < 4; j++) {
                assertEq(A[i][j], 69);
            }
        }
    }

    function testZeros() public {
        int256[][] memory A = Matrix.from(3, 4);

        assertEq(A.length, 3);
        assertEq(A[0].length, 4);
        assertEq(A[1].length, 4);
        assertEq(A[2].length, 4);

        for (uint256 i = 0; i < 3; i++) {
            for (uint256 j = 0; j < 4; j++) {
                assertEq(A[i][j], 0);
            }
        }

        assertEq(Matrix.from(3, 4), Matrix.zeros(3, 4));
    }

    function testOnes() public {
        int256[][] memory A = Matrix.ones(3, 4);

        assertEq(A.length, 3);
        assertEq(A[0].length, 4);
        assertEq(A[1].length, 4);
        assertEq(A[2].length, 4);

        for (uint256 i = 0; i < 3; i++) {
            for (uint256 j = 0; j < 4; j++) {
                assertEq(A[i][j], 1);
            }
        }

        assertEq(Matrix.fill(3, 4, 1), Matrix.ones(3, 4));
    }

    function testAdd() public {
        int256[][] memory A = Matrix.from(2, 2);
        int256[][] memory B = Matrix.from(2, 2);

        A[0][0] = 1;
        A[0][1] = 2;
        A[1][0] = 3;
        A[1][1] = 4;

        B[0][0] = 2;
        B[0][1] = 4;
        B[1][0] = 6;
        B[1][1] = 8;

        int256[][] memory X = A.add(B);

        assertEq(X[0][0], 3);
        assertEq(X[0][1], 6);
        assertEq(X[1][0], 9);
        assertEq(X[1][1], 12);
    }

    function testMul() public {
        int256[][] memory A = Matrix.from(2, 3);
        int256[][] memory B = Matrix.from(3, 2);

        A[0][0] = 2;
        A[0][1] = 3;
        A[0][2] = 4;
        A[1][0] = 1;
        A[1][1] = 0;
        A[1][2] = 0;

        B[0][0] = 0;
        B[0][1] = 1000;
        B[1][0] = 1;
        B[1][1] = 100;
        B[2][0] = 0;
        B[2][1] = 10;

        int256[][] memory X = A.mul(B);

        assertEq(X[0][0], 3);
        assertEq(X[0][1], 2340);
        assertEq(X[1][0], 0);
        assertEq(X[1][1], 1000);
    }

    function testScalar() public {
        int256[][] memory A = Matrix.from(2, 3);
        int256 B;

        A[0][0] = 2;
        A[0][1] = 3;
        A[0][2] = 4;
        A[1][0] = 1;
        A[1][1] = 0;
        A[1][2] = 0;

        B = 3;

        int256[][] memory X = A.mul(B);

        assertEq(X[0][0], 6);
        assertEq(X[0][1], 9);
        assertEq(X[0][2], 12);
        assertEq(X[1][0], 3);
        assertEq(X[1][1], 0);
        assertEq(X[1][2], 0);
    }
}
