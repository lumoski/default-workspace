// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;


contract Task_04 {
    function generateFibo(uint256 n) external pure returns (uint256) {
        uint256 a = 0;
        uint256 b = 1;
        uint256 next;
    
        do {
            next = a + b;
            a = b;
            b = next;
        } while (next <= n);
    
       return next;
   }
}