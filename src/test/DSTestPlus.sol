// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { DSTest } from "ds-test/test.sol";

contract DSTestPlus is DSTest {
    function assertEq(int256[][] memory a, int256[][] memory b) internal  {
        uint256 am = a.length;
        uint256 bm = a.length;
        uint256 an = a[0].length;
        uint256 bn = b[0].length;

        if (am != bm || an != bn) {
            emit log("Error: a == b dimensions not satisfied [int256[][]]");
            fail();
        }

        for (uint256 i = 0; i < am; i++) {
            for (uint256 j = 0; j < an; j++) {
                if (a[i][j] != b[i][j]) {
                    emit log("Error: a == b entries not satisfied [int256[][]]");
                    fail();
                }
            }
        }
    }
}
