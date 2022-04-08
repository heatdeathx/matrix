// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library Matrix {
    using Matrix for int256[][];

    function from(uint256 m, uint256 n) internal pure returns (int256[][] memory x) {
        x = new int256[][](m);

        for (uint256 i = 0; i < m; i++) {
            x[i] = new int256[](n);
        }
    }

    function shape(int256[][] memory a) internal pure returns (uint256 m, uint256 n) {
        return (a.length, a[0].length);
    }

    function fill(uint256 m, uint256 n, int256 value) internal pure returns (int256[][] memory x) {
        x = from(m, n);

        for (uint256 i = 0; i < m; i++) {
            for (uint256 j = 0; j < n; j++) {
                x[i][j] = value;
            }
        }
    }

    function zeros(uint256 m, uint256 n) internal pure returns (int256[][] memory x) {
        x = from(m, n);
    }

    function ones(uint256 m, uint256 n) internal pure returns (int256[][] memory x) {
        x = fill(m, n, 1);
    }

    function add(int256[][] memory a, int256[][] memory b) internal pure returns (int256[][] memory x) {
        uint256 m = a.length;
        uint256 n = a[0].length;
        require(m == b.length);
        require(n == b[0].length);

        x = from(m, n);

        for (uint256 i = 0; i < m; i++) {
            for (uint256 j = 0; j < n; j++) {
                x[i][j] = a[i][j] + b[i][j];
            }
        }
    }

    function mul(int256[][] memory a, int256[][] memory b) internal pure returns (int256[][] memory x) {
        uint256 l = a[0].length;
        require(l == b.length);

        (uint256 m, ) = a.shape();
        (, uint256 n) = b.shape();
        x = from(m, n);

        for (uint256 i = 0; i < m; i++) {
            for (uint256 j = 0; j < n; j++) {
                for (uint256 k = 0; k < l; k++) {
                    x[i][j] += a[i][k] * b[k][j];
                }
            }
        }
    }

    function mul(int256[][] memory a, int256 b) internal pure returns (int256[][] memory x) {
        (uint256 m, uint256 n) = a.shape();
        x = from(m, n);

        for (uint256 i = 0; i < m; i++) {
            for (uint256 j = 0; j < n; j++) {
                x[i][j] = a[i][j] * b;
            }
        }
    }
}
