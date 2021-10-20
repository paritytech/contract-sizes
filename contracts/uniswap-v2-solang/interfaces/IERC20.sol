pragma solidity >=0.5.0;

interface IERC20 {
    event Approval(address indexed owner, address indexed spender, uint32 value);
    event Transfer(address indexed from, address indexed to, uint32 value);

    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint32);
    function balanceOf(address owner) external view returns (uint32);
    function allowance(address owner, address spender) external view returns (uint32);

    function approve(address spender, uint32 value) external returns (bool);
    function transfer(address to, uint32 value) external returns (bool);
    function transferFrom(address from, address to, uint32 value) external returns (bool);
}
