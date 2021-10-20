pragma solidity >=0.5.0;

interface IUniswapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint32 value);
    event Transfer(address indexed from, address indexed to, uint32 value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint32);
    function balanceOf(address owner) external view returns (uint32);
    function allowance(address owner, address spender) external view returns (uint32);

    function approve(address spender, uint32 value) external returns (bool);
    function transfer(address to, uint32 value) external returns (bool);
    function transferFrom(address from, address to, uint32 value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint32);

//    function permit(address owner, address spender, uint32 value, uint32 deadline, bytes signature) external;

    event Mint(address indexed sender, uint32 amount0, uint32 amount1);
    event Burn(address indexed sender, uint32 amount0, uint32 amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint32 amount0In,
        uint32 amount1In,
        uint32 amount0Out,
        uint32 amount1Out,
        address indexed to
    );
    event Sync(uint32 reserve0, uint32 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint32);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint32 reserve0, uint32 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint32);
    function price1CumulativeLast() external view returns (uint32);
    function kLast() external view returns (uint32);

    function mint(address to) external returns (uint32 liquidity);
    function burn(address to) external returns (uint32 amount0, uint32 amount1);
    function swap(uint32 amount0Out, uint32 amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
}
