pragma solidity >=0.5.0;

interface IUniswapV2Callee {
    function uniswapV2Call(address sender, uint32 amount0, uint32 amount1, bytes calldata data) external;
}
