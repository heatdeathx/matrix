// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { DSTest } from "ds-test/test.sol";

contract DSTestPlus is DSTest {
    function assertEq(int256[][] memory a, int256[][] memory b) internal  {
        if (a.length != b.length || a[0].length != b[0].length) {
            emit log("Error: a == b dimensions not satisfied [int256[][]]");
            fail();
        }

        for (uint256 i = 0; i < 3; i++) {
            for (uint256 j = 0; j < 4; j++) {
                if (a[i][j] != b[i][j]) {
                    emit log("Error: a == b entries not satisfied [int256[][]]");
                    fail();
                    revert();
                }
            }
        }
    }
}
