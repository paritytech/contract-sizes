pragma solidity =0.5.16;

// a library for performing overflow-safe math, courtesy of DappHub (https://github.com/dapphub/ds-math)

library SafeMath {
    function add(uint32 x, uint32 y) internal pure returns (uint32 z) {
        require((z = x + y) >= x, 'ds-math-add-overflow');
    }

    function sub(uint32 x, uint32 y) internal pure returns (uint32 z) {
        require((z = x - y) <= x, 'ds-math-sub-underflow');
    }

    function mul(uint32 x, uint32 y) internal pure returns (uint32 z) {
        require(y == 0 || (z = x * y) / y == x, 'ds-math-mul-overflow');
    }
}
