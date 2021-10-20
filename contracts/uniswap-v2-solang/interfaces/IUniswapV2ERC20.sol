pragma solidity >=0.5.0;

interface IUniswapV2ERC20 {
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

//    function permit(address owner, address spender, uint32 value, uint32 deadline, bytes calldata signature) external;
}
